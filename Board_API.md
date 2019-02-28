# Board API
## 用户相关操作
### 登陆

 url:http://服务器IP地址:8000/board/login (POST方法)
 
 Content-Type:application/json
* request json
	```
	{"loginName":"hooo","password":"123"}
	```
* return json
	```
		{
		"flag": "1",
		"user": {
			"id": 2,
			"loginName": "hooo",
			"username": "hoo",
			"password": "123",
			"description": "loy",
			"profilePic": "ce552229cccb472cb3e6004203c2f780.jpg"
		}
	}
	```
	
### 注册


 url:http://服务器IP地址:8000/board/reg (POST方法)
 
 Content-Type:application/json
 

* request json
	```
	{
	"login_name":"hui",
	"username":"haoo",
	"password":"123"
	}
	```
* return json
	```
	{
	"flag": "1" //0代表失败 1代表成功
	}
	```
### 更新用户信息

 *如果需要更换头像需要先上传头像,之后使用传回的pic替换request json中的profilePic*

 url:http://服务器IP地址:8000/board/update (POST方法)
 
 Content-Type:application/json

* request
	```
	{
	"id":"2",//id一定要有,下面的可选，传改动的就行
	"loginName": "",
	"username": "",
	"password": "",
	"description": "",
	"profilePic": ""
	}
	```
* return json
	```
	{
	"flag": "1" //0代表失败 1代表成功
	}
	```
### 上传图片（用户头像，留言附带图片）

 url:http://服务器IP地址:8000/board/upload (POST方法)
 
 Content-Type:multipart/form-data

 * request  
	```
	*file*：需上传的图片。  
	*注意 key 是 file*
	```		
* return
	```
	{
		"flag": "success",//这里的 flag 不再用数字代替信息。因为失败的话会写明原因
		"pic": "5695c8eb49a741f380ffe81774b344d0.JPG" //成功才有，失败没有。
	}
	```
 ## 信息相关处理
 ### 添加新信息
  url:http://服务器IP地址:8000/board/addone (POST方法)
 
 Content-Type:application/json
 * request  
	```
	{
	"content":"as the city burns.",
	"pic":"ce552229cccb472cb3e6004203c2f780.jpg"
	}
	```
* return json
	```
	{
	"flag": "1" //0代表失败 1代表成功
	}
	```
### 获取所有信息（分页）
url:http://服务器IP地址:8000/board/msg (POST方法)
 
 Content-Type:application/json
 * request  
	```
	{
	"startPage":"2"//当前看的第几页
	}
	```
* return json
	```
	{
    "msgs": [
        {
            "username": "hoo",
            "profilePic": "ce552229cccb472cb3e6004203c2f780.jpg",
            "id": 3,
            "userid": 2,
            "content": "我是信息3",
            "date": "2019-02-06 17:38:03",
            "pic": "Xx.jpg"
        },```],//当前设置是一次加载12条信息
	"isHasPreviousPage": true,
    "isHasNextPage": false
	}
	```

 

