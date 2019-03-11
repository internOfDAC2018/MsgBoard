//  ViewController.swift
//  LoginTest
//  Copyright © 2019年 WuYiheng. All rights reserved.
import UIKit
var urlString = ""
class RegistorViewController: UIViewController,UITextFieldDelegate
{
    var a=1
    var Password=""
    var UserName=""
    var twicePassword=""
    var urlString=""
    var nickname=""
    var response=""
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //输入文本框及
        let label2 = UILabel(frame: CGRect(x: 150, y: 330, width: 100, height: 30))
        label2.text = "欢迎注册"
        label2.textColor = UIColor.black
        self.view.addSubview(label2)
        
        let textField = UITextField(frame: CGRect(x:100,y:360,width:200,height:30))
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth=1
        textField.layer.cornerRadius = 6
        textField.returnKeyType = UIReturnKeyType.done
        textField.delegate=self
        self.view.addSubview(textField)
        textField.placeholder="请输入用户名"
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let nickname = UITextField(frame: CGRect(x:100,y:400,width:200,height:30))
        nickname.layer.borderColor = UIColor.gray.cgColor
        nickname.layer.borderWidth=1
        nickname.layer.cornerRadius = 6
        nickname.returnKeyType = UIReturnKeyType.done
        nickname.delegate=self
        self.view.addSubview(nickname)
        nickname.placeholder="您的昵称"
        nickname.addTarget(self, action: #selector(nicknameDidChange(_:)), for: .editingChanged)
        
        let textField2 = UITextField(frame: CGRect(x:100,y:440,width:200,height:30))
        textField2.layer.borderColor = UIColor.gray.cgColor
        textField2.layer.borderWidth=1
        textField2.layer.cornerRadius = 6
        textField2.returnKeyType = UIReturnKeyType.done
        textField2.delegate=self
        self.view.addSubview(textField2)
        textField2.placeholder="请输入密码"
        textField2.isSecureTextEntry = true
        textField2.addTarget(self, action: #selector(textField2Change(_:)), for: .editingChanged)
        
        let textField3 = UITextField(frame: CGRect(x:100,y:480,width:200,height:30))
        textField3.layer.borderColor = UIColor.gray.cgColor
        textField3.layer.borderWidth=1
        textField3.layer.cornerRadius = 6
        textField3.returnKeyType = UIReturnKeyType.done
        textField3.delegate=self
        self.view.addSubview(textField3)
        textField3.placeholder="请再次确认密码"
        textField3.isSecureTextEntry = true
        textField3.addTarget(self, action: #selector(textField3(_:)), for: .editingChanged)
        
        let button = UIButton(frame: CGRect(x: 100, y: 520, width: 200, height: 30))
        button.setTitle("注册", for: .normal)
        button.setTitleColor(UIColor.red, for: UIControlState.normal)
        button.setTitleShadowColor(UIColor.green, for:.normal)
        button.backgroundColor=UIColor.yellow
        button.addTarget(self, action: #selector(self.buttonTapped(sender:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
    func textFieldDidChange(_ textField:UITextField) -> Bool {
        
        print(textField.text)
        UserName=textField.text!
        let loginNamecheck = ["loginName": UserName]
        NetworkTools.shardTools.request(method: .Post, urlString: "http://192.168.253.7:8000/board/check", parameters: loginNamecheck as AnyObject?)
        { (responseObject, error) in
            if error != nil {print(error!);return}
            guard (responseObject as? [String : AnyObject]) != nil else{return}
            print(responseObject!)
            let jsonStr = responseObject as! [String: AnyObject]
            let user = jsonStr["flag"]
            print (user)
            self.response=user as! String
            if self.response=="1" {print("合法的用户名")}
            else {
                let alertController3 = UIAlertController(title: "系统提示", message: "此用户已被注册",preferredStyle: .alert)
                let cancelAction1 = UIAlertAction(title: "确定", style: .destructive,handler: nil)
                alertController3.addAction(cancelAction1)
                self.present(alertController3, animated: true, completion: nil)
            }
        }
        return true
    }
    func nicknameDidChange(_ textField:UITextField) -> Bool {
        
        print(textField.text)
        nickname=textField.text!
        return true
    }
    func textField2Change(_ textField:UITextField) -> Bool {
        
        print(textField.text)
        Password=textField.text!
        return true
    }
    func textField3(_ textField:UITextField) -> Bool {
        
        print(textField.text)
        twicePassword=textField.text!
        return true
    }
    //注册键
    @objc func buttonTapped(sender: UIButton) {
        //两次密码相同
        if Password == twicePassword{
            let registcheck = ["loginName":UserName,"username":nickname,"password":Password]
            print(registcheck)
            NetworkTools.shardTools.request(method: .Post, urlString: "http://192.168.253.7:8000/board/reg", parameters: registcheck as AnyObject?)
            { (responseObject, error) in
                if error != nil {print(error!);return}
                guard (responseObject as? [String : AnyObject]) != nil else{return}
                print(responseObject!)
                let jsonStr = responseObject as! [String: AnyObject]
                let user = jsonStr["flag"];print (user)
                self.response=user as! String
                //判断是否注册成功
                if self.response=="1" {
                    let alertController2 = UIAlertController(title: "注册成功", message: "返回登录页面",preferredStyle: .alert)
                    let cancelAction1 = UIAlertAction(title: "确定", style: .destructive,handler: nil)
                    let firstPage=FirstViewController()
                    self.navigationController!.pushViewController(firstPage, animated: true)
                    alertController2.addAction(cancelAction1)
                    self.present(alertController2, animated: true, completion: nil)
                }
                else {let alertController3 = UIAlertController(title: "系统提示", message: "此用户已被注册",preferredStyle: .alert)
                    let cancelAction1 = UIAlertAction(title: "确定", style: .destructive,handler: nil)
                    alertController3.addAction(cancelAction1)
                    self.present(alertController3, animated: true, completion: nil)}
            }}
            //两次密码不相同
        else {print("密码不一致")
            let alertController = UIAlertController(title: "请重新输入", message: "两次密码输入不一致",preferredStyle: .alert)
            let cancelAction1 = UIAlertAction(title: "取消", style: .destructive, handler: nil)
            let cancelAction2 = UIAlertAction(title: "确定", style: .cancel, handler: nil)
            alertController.addAction(cancelAction1)
            alertController.addAction(cancelAction2)
            self.present(alertController, animated: true, completion: nil)
        }
        print("用户名是：",UserName,"密码是",Password,"确认密码是",twicePassword)
    }
}
