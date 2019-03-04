package cn.cs.Board.Controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONObject;

import cn.cs.Board.dao.model.Msg;
import cn.cs.Board.dao.model.User;
import cn.cs.Board.service.IMsgService;

@RestController
public class MsgController {
	@Autowired
	private IMsgService msgService;
	private static final Logger logger=LoggerFactory.getLogger(MsgController.class);
	
	@RequestMapping(value= {"/msg"},method = {RequestMethod.POST})
	public JSONObject getAllMsg(@RequestBody JSONObject params,HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		User u=(User) session.getAttribute("user");
		if(u!=null)
		{
			int startPage=params.getIntValue("startPage");
			logger.info("show the page NO."+startPage);
			JSONObject o=this.msgService.getAll(startPage);
			return o;
		}
		else
		{
			logger.info("can't get the user msg in session");
			return null;
		}
	}
	
	@RequestMapping(value= {"/addone"},method = {RequestMethod.POST})
	public JSONObject addOne(@RequestBody Msg m,HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		User u=(User) session.getAttribute("user");
		JSONObject o=new JSONObject();
		if(u!=null)
		{
			logger.info("about to add new msg... ");
			m.setUserid(u.getId());
			m.setDate(new Date());
			logger.info(m.getDate().toString());
			boolean result=this.msgService.addOne(m);
			if(result)
			{
				o.put("flag","1");
				logger.info("add new msg success");
				return o;
			}
			else
			{
				o.put("flag","0");
				logger.info("add new msg failure");
				return o;
			}
		}
		else{
			logger.info("can't get the user msg in session");
			return null;
		}
	}

}
