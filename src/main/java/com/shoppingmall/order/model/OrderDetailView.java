package com.shoppingmall.order.model;

import java.util.List;

import com.shoppingmall.address.model.Address;
import com.shoppingmall.user.model.User;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderDetailView {
	
	// order 1개
	private Order order;
	
	// order 1개에 대한 orderProduct
	private List<OrderAdminView> orderAdminViewList;
	
	private User user;
	
	private Address address;
	
	private String orderProductName;
	
	// 배송 완료 여부
	private boolean deliveryCheck;
}
