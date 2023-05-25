package com.shoppingmall.user.bo;

import java.util.List;

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
	
	public int addUser(User user) {
		return userMapper.insertUser(user);
	}
	
	public User getUserByLoginIdPassword(String loginId, String password) {
		return userMapper.selectUserByLoginIdPassword(loginId, password);
	}
	
	public List<User> getUserListByEmail(String email) {
		return userMapper.selectUserListByEmail(email);
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
	
	public int updateLoginIdByUserId(String loginId, int userId) {
		return userMapper.updateLoginIdByUserId(loginId, userId);
	}
	
	public int updateNamerByUserId(String name, int userId) {
		return userMapper.updateNamerByUserId(name, userId);
	}
	
	public int updateEmailByUserId(String email, int userId) {
		return userMapper.updateEmailByUserId(email, userId);
	}
	
	public int updatePhoneNumber(String phoneNumber, int userId) {
		return userMapper.updatePhoneNumber(phoneNumber, userId);
	}
	
	public int updatePWByUserId(String password, int userId) {
		return userMapper.updatePWByUserId(password, userId);
	}
	
	public User getUserByUserId(int userId) {
		return userMapper.selectUserByUserId(userId);
	}
	
	public User getUserByLoginIdEmail(String loginId, String email) {
		return userMapper.selectUserByLoginIdEmail(loginId, email);
	}
}
