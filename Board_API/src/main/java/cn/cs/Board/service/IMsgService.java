package cn.cs.Board.service;

import cn.cs.Board.dao.model.Msg;
import java.util.List;

import com.alibaba.fastjson.JSONObject;

public interface IMsgService {
	JSONObject getAll(int startPage) ;
	boolean addOne(Msg m);
}
