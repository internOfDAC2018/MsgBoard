package cn.cs.Board.service;

import cn.cs.Board.dao.model.User;

public interface IUserService {

	User getUser(String loginName,String password);
	boolean register(String loginName,String username,String password);
	boolean checkUserName(String loginName);
	boolean update(User u);
		
	
}
