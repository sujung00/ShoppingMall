package com.shoppingmall.order;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.shoppingmall.order.bo.CancelRefundBO;
import com.shoppingmall.order.bo.OrderProductBO;

@RequestMapping("/order_admin")
@RestController
public class OrderAdminRestController {
	
	@Autowired
	private OrderProductBO orderProductBO;
	
	@Autowired
	private CancelRefundBO cancelRefundBO;

	@PostMapping("/state_update")
	public Map<String, Object> stateUpdate(
			@RequestParam("state") String state,
			@RequestParam("orderProductId") int orderProductId){
		// db update
		int rowCount = orderProductBO.updateStateByOrderProductId(state, orderProductId);
		
		Map<String, Object> result = new HashMap<>();
		if(rowCount > 0) {
			result.put("code", 1);
			result.put("result", "변경 완료");
		} else {
			result.put("code", 500);
			result.put("errorMesasge", "변경 실패");
		}
		
		return result;
	}
	
	@PostMapping("/cancel_refund_create")
	public Map<String, Object> cancelRefundCreate(
			@RequestParam("orderProductId") int orderProductId,
			@RequestParam("reason") String reason,
			@RequestParam("state") String state){
		// db insert
		int rowCount = cancelRefundBO.addCancelRefund(orderProductId, reason, state);
		
		Map<String, Object> result = new HashMap<>();
		if(rowCount > 0) {
			result.put("code", 1);
			result.put("result", "취소/환불 생성 성공");
		} else {
			result.put("code", 500);
			result.put("errorMessage", "취소/환불 생성 실패");
		}
		
		return result;
	}
	
	@PostMapping("/cancel_refund_delete")
	public Map<String, Object> cancelRefundDelete(
			@RequestParam("cancelRefundId") int cancelRefundId){
		// db delete
		int rowCount = cancelRefundBO.deleteCancelRefund(cancelRefundId);
		
		Map<String, Object> result = new HashMap<>();
		if(rowCount > 0) {
			result.put("code", 1);
			result.put("result", "취소/환불 삭제 성공");
		} else {
			result.put("code", 500);
			result.put("errorMessage", "취소/환불 삭제 실패");
		}
		
		return result;
	}
	
	@PostMapping("/cancel_refund_update")
	public Map<String, Object> cancelRefundUpdate(
			@RequestParam("cancelRefundId") int cancelRefundId,
			@RequestParam("reason") String reason){
		// db update
		int rowCount = cancelRefundBO.updateReasonByCancelRefundId(cancelRefundId, reason);
		
		Map<String, Object> result = new HashMap<>();
		if(rowCount > 0) {
			result.put("code", 1);
			result.put("result", "취소/환불 사유 수정 성공");
		} else {
			result.put("code", 500);
			result.put("errorMessage", "취소/환불 사유 수정 실패");
		}
		
		return result;
		
	}
}
