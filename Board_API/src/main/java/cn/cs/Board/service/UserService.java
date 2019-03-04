package cn.cs.Board.service;

import java.io.UnsupportedEncodingException;
import java.util.Base64;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import cn.cs.Board.Controller.MsgController;
import cn.cs.Board.dao.mapper.UserMapper;
import cn.cs.Board.dao.model.User;
import cn.cs.Board.dao.model.UserExample;
import cn.cs.Board.dao.model.UserExample.Criteria;

@Transactional(value = "transactionManager", rollbackFor = Exception.class, isolation = Isolation.READ_COMMITTED, timeout = 300)
@Service
public class UserService implements IUserService {
	
	//当容器扫描到@Autowied、@Resource或@Inject时，就会在IoC容器自动查找需要的bean，并装配给该对象的属性
	@Autowired
	private UserMapper userMapper;
	private static final Logger logger=LoggerFactory.getLogger(UserService.class);
	
    final Base64.Decoder decoder = Base64.getDecoder();
    final Base64.Encoder encoder = Base64.getEncoder();
    
    @Override
    @Cacheable(value = "cn.cs.Board.dao.model.User", key = "#root.targetClass + #root.methodName")
	public User getUser(String loginName,String password) {
		
		UserExample fe = new UserExample();
		
		Criteria criteria =fe.createCriteria();
		
		byte[] textByte = null;
		try {
			textByte = password.getBytes("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		criteria.andLoginNameEqualTo(loginName);
		criteria.andPasswordEqualTo(encoder.encodeToString(textByte));
		
		List<User> users=userMapper.selectByExample(fe);
		logger.info("查到符合条件的users "+users.size());
		  if(users.size()==1)
	        {
	            User u=users.get(0);
	            u.setPassword(password);
	            return u;
	        }
	        else
	        {
	            return null;
	        }
	}
    
    @Override
    @Cacheable(value = "cn.cs.Board.dao.model.User", key = "#root.targetClass + #root.methodName")
	public boolean register(String loginName,String username,String password) {	
	        try {
	            byte[] textByte = password.getBytes("UTF-8");
	            password=encoder.encodeToString(textByte);
	        } catch (UnsupportedEncodingException e) {
	        	// TODO Auto-generated catch block
				e.printStackTrace();
	        }
	        User record=new User();
	        record.setLoginName(loginName);
	        record.setUsername(username);
	        record.setPassword(password);
	        int result=userMapper.insertSelective(record);
	        if(result>0)
	            return true;
	        else
	            return false;	        
	}
    
    @Override
    @Cacheable(value = "cn.cs.Board.dao.model.User", key = "#root.targetClass + #root.methodName")
	public boolean checkUserName(String loginName) {
		UserExample fe = new UserExample();
		
		Criteria criteria =fe.createCriteria();
		criteria.andLoginNameEqualTo(loginName);
		
		List<User> users=userMapper.selectByExample(fe);
		
		  if(users.size()==0)
	        {
			  logger.info("查到的同样的用户名有 "+users.size());
	            return true;
	        }
		  else 
		  {
			  logger.info("查到的同样的用户名有 "+users.size());
			  return false;
		  }
	}
    
    @Override
    @Cacheable(value = "cn.cs.Board.dao.model.User", key = "#root.targetClass + #root.methodName")
	public boolean update(User record) {
    	UserExample fe=new UserExample();
    	Criteria criteria=fe.createCriteria();
    	criteria.andIdEqualTo(record.getId());
    	User u=new User();
    	if(record.getDescription()!=null)
    	{
    		u.setDescription(record.getDescription());
    	}
    	if(record.getPassword()!=null)
    	{
    		u.setPassword(record.getPassword());
    	}
    	if(record.getProfilePic()!=null)
    	{
    		u.setProfilePic(record.getProfilePic());
    	}
    	if(record.getUsername()!=null)
    	{
    		u.setUsername(record.getUsername());
    	}
    	logger.info("to be written into DB is"+u.toString());
		int result=userMapper.updateByExampleSelective(u,fe);
		if(result==1)
		{
			return true;
		}else
		{
			return false;
		}
	}
}
