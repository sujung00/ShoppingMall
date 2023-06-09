package com.shoppingmall.order.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shoppingmall.address.bo.AddressBO;
import com.shoppingmall.address.model.Address;
import com.shoppingmall.basket.bo.BasketBO;
import com.shoppingmall.basket.bo.BasketProductBO;
import com.shoppingmall.basket.model.Basket;
import com.shoppingmall.basket.model.BasketView;
import com.shoppingmall.order.model.Order;
import com.shoppingmall.order.model.OrderAdminView;
import com.shoppingmall.order.model.OrderDetailView;
import com.shoppingmall.order.model.OrderProduct;
import com.shoppingmall.order.model.OrderView;
import com.shoppingmall.point.bo.PointBO;
import com.shoppingmall.product.bo.ProductBO;
import com.shoppingmall.product.model.Product;
import com.shoppingmall.productOption.bo.ProductOptionBO;
import com.shoppingmall.productOption.model.ProductOption;
import com.shoppingmall.user.bo.UserBO;
import com.shoppingmall.user.model.User;

@Service
public class OrderServiceBO {

	@Autowired
	private BasketBO basketBO;
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private BasketProductBO basketProductBO;
	
	@Autowired
	private AddressBO addressBO;
	
	@Autowired
	private PointBO pointBO;
	
	@Autowired
	private OrderBO orderBO;
	
	@Autowired
	private OrderProductBO orderProductBO;
	
	@Autowired
	private ProductOptionBO productOptionBO;
	
	@Autowired
	private ProductBO productBO;
	
	@Transactional
	public OrderView generateOrderView(int basketId) {
		OrderView orderView = new OrderView();
		
		// 장바구니 1개
		Basket basket = basketBO.getBasketByBasketId(basketId);
		orderView.setBasket(basket);
		
		// user
		int userId = basket.getUserId();
		User user = userBO.getUserByUserId(userId);
		orderView.setUser(user);
		
		// 장바구니 상품들
		List<BasketView> basketViewList = basketProductBO.generateBasket(userId);
		orderView.setBasketViewList(basketViewList);
		
		// 배송지 목록
		List<Address> addrssList = addressBO.getAddressListByUserId(userId);
		orderView.setAddressList(addrssList);
		
		// 포인트
		int point = pointBO.getTotalPointByUserId(userId);
		orderView.setTotalPoint(point);
		
		return orderView;
	}
	
	@Transactional
	public List<OrderDetailView> generateOrderDetailListView(int userId){
		List<OrderDetailView> orderDetailViewList = new ArrayList<>();
		
		List<Order> orderList = orderBO.getOrderListByUserId(userId);
		for(Order order : orderList) {
			OrderDetailView orderDetailView = new OrderDetailView();
			
			orderDetailView.setOrder(order);

			List<OrderAdminView> orderAdminViewList = new ArrayList<>();
			List<OrderProduct> orderProductList = orderProductBO.getOrderProductListByOrderId(order.getId());
			for(OrderProduct orderProduct : orderProductList) {
				OrderAdminView orderAdminView = new OrderAdminView();
				
				orderAdminView.setOrderProduct(orderProduct);
				
				Product product = productBO.getProductByProductId(orderProduct.getProductId());
				orderAdminView.setProduct(product);
				
				ProductOption productOption = productOptionBO.getProductOptionByProductOptionId(orderProduct.getOptionId());
				orderAdminView.setProductOption(productOption);
				
				orderAdminViewList.add(orderAdminView);
			}
			orderDetailView.setOrderAdminViewList(orderAdminViewList);
			
			orderDetailViewList.add(orderDetailView);
		}
		
		return orderDetailViewList;
	}
	
	@Transactional
	public OrderDetailView generateOrderDetailView(int orderId) {
		OrderDetailView orderDetailView = new OrderDetailView();
		
		Order order = orderBO.getOrderByOrderId(orderId);
		orderDetailView.setOrder(order);
		
		boolean deliveryCheck = true;
		List<OrderAdminView> orderAdminViewList = new ArrayList<>();
		List<OrderProduct> orderProductList = orderProductBO.getOrderProductListByOrderId(order.getId());
		for(OrderProduct orderProduct : orderProductList) {
			OrderAdminView orderAdminView = new OrderAdminView();
			
			orderAdminView.setOrderProduct(orderProduct);
			
			Product product = productBO.getProductByProductId(orderProduct.getProductId());
			orderAdminView.setProduct(product);
			
			ProductOption productOption = productOptionBO.getProductOptionByProductOptionId(orderProduct.getOptionId());
			orderAdminView.setProductOption(productOption);
			
			List<String> colorList = productOptionBO.getColorByProductId(orderProduct.getProductId());
			orderAdminView.setColorList(colorList);
			
			
			// 배송 완료된 상품이거나 주문 취소이면 false
			if(orderProduct.getState().equals("배송완료") || orderProduct.getState().equals("주문취소") || orderProduct.getState().equals("결제대기")) {
				deliveryCheck = false;
			}
			
			orderAdminViewList.add(orderAdminView);
			
		}
		orderDetailView.setOrderAdminViewList(orderAdminViewList);
		
		User user = userBO.getUserByUserId(order.getUserId());
		orderDetailView.setUser(user);
		
		Address address = addressBO.getAddressByAddressId(order.getAddressId());
		orderDetailView.setAddress(address);
		
		Product product = productBO.getProductByProductId(orderProductList.get(0).getProductId());
		String orderProductName = null;
		if(orderProductList.size() == 1) {
			orderProductName = product.getName();
		} else {
			// ex) 미니멀 크롭 브이넥 가디건 외 2개 상품
			orderProductName = product.getName() + " 외 " + String.valueOf(orderProductList.size()-1) + "개 상품";
		}
		orderDetailView.setOrderProductName(orderProductName);
		
		orderDetailView.setDeliveryCheck(deliveryCheck);
		
		return orderDetailView;
	}
}
