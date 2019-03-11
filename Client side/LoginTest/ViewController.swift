//  ViewController.swift
//  LoginTest
//  Copyright © 2019年 WuYiheng. All rights reserved.
import UIKit
import WebKit
var myPortrait=""
var loginName="吴以恒"
var introduce="这是一个好人"
var id=""
var mybaseaddress="http://192.168.253.7:8000/board/images/"
var MESSAGE="未有评论"
var Pic=""
var ProfilePic=""
var Picture=""
var Jsonaddress=""
class FirstViewController: UIViewController,UITextFieldDelegate{
    var a=1
    var Password=""
    var UserName=""
    var twicePassword=""
    var urlString="http://192.168.253.7:8000/board/login"
    var response=""
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
        override func viewDidLoad() {
        super.viewDidLoad()
                view.backgroundColor = UIColor.white
                let infoLabel = UILabel(frame: CGRect(x: 150, y: 330, width: 100, height: 30))
                infoLabel.text="欢迎登陆"
                infoLabel.numberOfLines=0
                infoLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                infoLabel.textColor = UIColor.black
                infoLabel.font = UIFont .systemFont(ofSize: 16)
                self.view.addSubview(infoLabel)

            let textField = UITextField(frame: CGRect(x:100,y:360,width:200,height:30))
            textField.layer.borderColor = UIColor.gray.cgColor
            textField.layer.borderWidth=1
            textField.layer.cornerRadius = 6
            textField.returnKeyType = UIReturnKeyType.done
            textField.delegate=self
            self.view.addSubview(textField)
            textField.placeholder="请输入用户名"
            textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        
            let textField2 = UITextField(frame: CGRect(x:100,y:400,width:200,height:30))
            textField2.layer.borderColor = UIColor.gray.cgColor
            textField2.layer.borderWidth=1
            textField2.layer.cornerRadius = 6
            textField2.returnKeyType = UIReturnKeyType.done
            textField2.delegate=self
            self.view.addSubview(textField2)
            textField2.placeholder="请输入密码"
            textField2.isSecureTextEntry = true
            textField2.addTarget(self, action: #selector(TextDidChange(_:)), for: .editingChanged)
            //登陆按钮
            let button = UIButton(frame: CGRect(x: 100, y: 450, width: 100, height: 30))
            button.setTitle("登陆", for: .normal)
            button.setTitleColor(UIColor.red, for: UIControlState.normal)
            button.setTitleShadowColor(UIColor.green, for:.normal)
            button.backgroundColor=UIColor.yellow
            button.addTarget(self, action: #selector(self.buttonTapped(sender:)), for: .touchUpInside)
            view.addSubview(button)
                
            let buttonRegister = UIButton(frame: CGRect(x: 220, y: 450, width: 100, height: 30))
            buttonRegister.setTitle("注册", for: .normal)
            buttonRegister.setTitleColor(UIColor.red, for: UIControlState.normal)
            buttonRegister.setTitleShadowColor(UIColor.green, for:.normal)
            buttonRegister.backgroundColor=UIColor.yellow
            buttonRegister.addTarget(self, action: #selector(self.buttonRegister(sender:)), for: .touchUpInside)
            view.addSubview(buttonRegister)
}

    @objc func buttonTapped(sender: UIButton) {
        print("用户名是：",UserName,"密码是",Password)
 
        //post请求，判断用户名密码是否正确，返回Json
        let params = ["loginName": UserName, "password":Password]
        NetworkTools.shardTools.request(method: .Post, urlString: urlString, parameters: params as AnyObject?)
        { (responseObject, error) in
            if error != nil {print(error!);return}
            guard (responseObject as? [String : AnyObject]) != nil else{return}
            print(responseObject!)
            
            //JSON解析部分
            let jsonStr = responseObject as! [String: AnyObject]
            let user = jsonStr["flag"]
            let ccc=JSON(jsonStr["user"])
            
            let LoginName=ccc["username"];
            loginName = LoginName.description
            
            let Introduce=ccc["description"];
            introduce = Introduce.description
            let JSonaddress=ccc["profilePic"];
            Jsonaddress = JSonaddress.description
            let ID=ccc["id"]
            id=ID.description
            self.response=user as! String
            if self.response=="1"
            {
             myPortrait=mybaseaddress+Jsonaddress
                let alertController2 = UIAlertController(title: "登陆成功", message: "进入留言板",preferredStyle: .alert)
                let cancelAction1 = UIAlertAction(title: "确定", style: .destructive, handler: nil)
                let mesboardPage=Mesboard()
                self.navigationController!.pushViewController(mesboardPage, animated: true)
                alertController2.addAction(cancelAction1)
                self.present(alertController2, animated: true, completion: nil)
}
            else
            {   let loginMessage = UIAlertController(title: "系统提示", message: "用户名密码错误",preferredStyle: .alert)
                let cancelAction1 = UIAlertAction(title: "重新登录", style: .destructive, handler: nil)
                loginMessage.addAction(cancelAction1)
                self.present(loginMessage, animated: true, completion: nil)
}
        }
    }
     @objc func buttonRegister(sender: UIButton) {
        print("新用户注册")
        let registorPage=RegistorViewController()
        self.navigationController!.pushViewController(registorPage, animated: true)
            }

    @objc func uploadtest(sender: UIButton) {
        print("上传图片测试")
        let uploadPage=uploadtestViewController()
        self.navigationController!.pushViewController(uploadPage, animated: true)
    }
    
    
    func textDidChange(_ textField:UITextField) -> Bool {
        print(textField.text)
        UserName=textField.text!
        return true
    }
    func TextDidChange(_ textField:UITextField) -> Bool {
        print(textField.text)
        Password=textField.text!
        return true
    }
    
    @objc func biggertest(sender: UIButton)
    {
//        let uploadPage=test()
//        self.navigationController!.pushViewController(uploadPage, animated: true)
    }

}
    
