package com.shoppingmall.interceptor;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class PermissionInterceptor implements HandlerInterceptor {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {
		
		// 요청 url을 가져온다.
		String uri = request.getRequestURI();
		logger.info("[#####preHandler#####] uri:{}", uri);
		
		// 로그인 여부 확인 - 세션 확인
		HttpSession session = request.getSession();
		Integer userId =(Integer)session.getAttribute("userId");
		String userLoginId = (String)session.getAttribute("userLoginId");
		
		// 비로그인 && /product 가 아닌 경우 => 로그인 페이지로 redirect, return false(기존 컨트롤러 수행 방지)
		if(userId == null && !uri.startsWith("/product/") && !uri.startsWith("/images/") && !uri.startsWith("/user/sign_in") && !uri.startsWith("/user/sign_up") && !uri.startsWith("/user/kakao") && !uri.startsWith("/main")) {
			response.sendRedirect("/user/sign_in_view");
			return false; // controller 수행 안됨
		}
		
		// admin user가 아닌데 admin 페이지 일 경우
		if(userId != null && !userLoginId.equals("admin") && (uri.startsWith("/inquiry_admin") || uri.startsWith("/order_admin") || uri.startsWith("/product_admin") || uri.startsWith("/product_option"))) {
			response.sendRedirect("/main/main_view");
			return false;
		}
		
		if(userId != null && userLoginId.equals("admin") && !uri.startsWith("/inquiry_admin") && !uri.startsWith("/order_admin") && !uri.startsWith("/product_admin") && !uri.startsWith("/product_option") && !uri.startsWith("/user/sign_in") && !uri.startsWith("/user/sign_up") && !uri.startsWith("/main")) {
			response.sendRedirect("/main/main_view");
			return false;
		}
			
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler, ModelAndView mav) {
		
		// view 객체가 존재한다는 것은 아직 jsp가 HTML로 변환되기 전이다.
		logger.info("[$$$$$postHandle$$$$$]");
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response,
			Object handler, Exception ex) {
		// jsp가 HTML로 최종 변환 된 후
		logger.info("[@@@@@afterCompletion@@@@@]");
	}
	
}
