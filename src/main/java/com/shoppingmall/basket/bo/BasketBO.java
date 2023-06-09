package com.shoppingmall.basket.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shoppingmall.basket.dao.BasketMapper;
import com.shoppingmall.basket.model.Basket;

@Service
public class BasketBO {

	@Autowired
	private BasketMapper basketMapper;

	@Transactional
	public void addBasket(int userId) {
		basketMapper.insertBasket(userId);
	}

	public Basket getBasketByUserId(int userId) {
		return basketMapper.selectBasketByUserId(userId);
	}

	@Transactional
	public void updateTotalPrice(int basketId, int totalPrice) {
		basketMapper.updateTotalPrice(basketId, totalPrice);
	}

	public Basket getBasketByBasketId(int basketId) {
		return basketMapper.selectBasketByBasketId(basketId);
	}
}
