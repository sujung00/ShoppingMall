package com.shoppingmall.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shoppingmall.user.dao.UserMapper;
import com.shoppingmall.user.model.User;

@Service
public class UserBO {

	@Autowired
	private UserMapper userMapper;
	
	public User getUserByLoginId(String loginId) {
		return userMapper.selectUserByLoginId(loginId);
	}
	
	public int addUser(String loginId, String password, String name, String email, String phoneNumber) {
		return userMapper.insertUser(loginId, password, name, email, phoneNumber);
	}
	
	public User getUserByLoginIdPassword(String loginId, String password) {
		return userMapper.selectUserByLoginIdPassword(loginId, password);
	}
	
	public User getUserByEmail(String email) {
		return userMapper.selectUserByEmail(email);
	}
	
	public String getLoginIdByNameEmail(String name, String email) {
		return userMapper.selectLoginIdByNameEmail(name, email);
	}
	
	public User getUserByLoginIdNameEmail(String loginId, String name, String email) {
		return userMapper.selectUserByLoginIdNameEmail(loginId, name, email);
	}
	
	public void updateUserPassword(int userId, String password) {
		userMapper.updateUserPassword(userId, password);
	}
}