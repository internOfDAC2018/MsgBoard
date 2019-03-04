package cn.cs.Board.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.cs.Board.dao.mapper.MsgMapper;
import cn.cs.Board.dao.model.Msg;
import cn.cs.Board.dao.model.MsgExample;

@Transactional(value = "transactionManager", rollbackFor = Exception.class, isolation = Isolation.READ_COMMITTED, timeout = 300)
@Service
public class MsgService implements IMsgService {
	@Autowired
	private MsgMapper msgMapper;
	private static final Logger logger=LoggerFactory.getLogger(MsgService.class);

	@Override
	@Cacheable(value = "cn.cs.Board.dao.model.User", key = "#root.targetClass + #root.methodName")
	public JSONObject getAll(int startPage) {
		//PageInterceptor在MyBatisConfig配置了拦截器插件
		//获取startPage页的内容，12条.
		PageHelper.startPage(startPage,12);
		MsgExample fe=new MsgExample();
		fe.setOrderByClause("date desc");
		List<Msg> msgs=msgMapper.selectByExample(fe);
		PageInfo<Msg> page= new PageInfo<>(msgs);
		JSONObject o=new JSONObject();
		o.put("msgs", page.getList());
		o.put("isHasNextPage", page.isHasNextPage());
		o.put("isHasPreviousPage",page.isHasPreviousPage());
		return o;
	}

	@Override
	@Cacheable(value = "cn.cs.Board.dao.model.User", key = "#root.targetClass + #root.methodName")
	public  boolean addOne(Msg m) {
		int result=msgMapper.insertSelective(m);
		logger.info("msg insert sql result : "+result);
		if(result==1)
		{
			return true;
		}
		else {
			return false;
		}
	}

}
