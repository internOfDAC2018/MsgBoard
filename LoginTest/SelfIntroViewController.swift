//  ViewController.swift
//  LoginTest
//  Copyright © 2019年 WuYiheng. All rights reserved.
import UIKit
var newloginName = ""
var newintroduce = ""
class SelfIntroViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate
{
    var dataofSelfIntro:Data?
    var response=""
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let tile = UILabel(frame: CGRect(x: 170, y: 0, width: 100, height: 200))
        tile.text = "个人信息"
        tile.textColor = UIColor.black
        self.view.addSubview(tile)
        
        let name = UILabel(frame: CGRect(x: 80, y: 70, width: 100, height: 230))
        name.text = "用户名:"
        name.textColor = UIColor.black
        self.view.addSubview(name)

        let picture = UILabel(frame: CGRect(x: 80, y: 170, width: 100, height: 230))
        picture.text = "头像:"
        picture.textColor = UIColor.black
        self.view.addSubview(picture)

        let intro = UILabel(frame: CGRect(x: 80, y: 270, width: 100, height: 230))
        intro.text = "简介:"
        intro.textColor = UIColor.black
        self.view.addSubview(intro)

        let frame = CGRect(x: 0, y: 125, width: 400, height: 100)
        let cgView = CGView(frame: frame)
        self.view.addSubview(cgView)
        
        let textField = UITextField(frame: CGRect(x:180,y:170,width:150,height:30))
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth=1
        textField.layer.cornerRadius = 6
        textField.returnKeyType = UIReturnKeyType.done
        textField.delegate=self
        self.view.addSubview(textField)
        textField.placeholder=loginName
        textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
    
        let textField2 = UITextField(frame: CGRect(x:180,y:370,width:150,height:30))
        textField2.layer.borderColor = UIColor.gray.cgColor
        textField2.layer.borderWidth=1
        textField2.layer.cornerRadius = 6
        textField2.returnKeyType = UIReturnKeyType.done
        textField2.delegate=self
        self.view.addSubview(textField2)
        textField2.placeholder=introduce
        textField2.addTarget(self, action: #selector(TextDidChange(_:)), for: .editingChanged)
        
        let button = UIButton(frame: CGRect(x: 70, y: 450, width: 260, height: 30))
        button.setTitle("保存", for: .normal)
        button.setTitleColor(UIColor.red, for: UIControlState.normal)
        button.setTitleShadowColor(UIColor.green, for:.normal)
        button.backgroundColor=UIColor.yellow
        button.addTarget(self, action: #selector(self.buttonTapped(sender:)), for: .touchUpInside)
        view.addSubview(button)

        
        
        let url=URL(string: mybaseaddress+Jsonaddress)
        let data = try!Data(contentsOf: url!)
        let newImage=UIImage(data: data)
        let imageView=UIImageView(image:newImage);
        imageView.frame = CGRect(x:180, y:220, width:130, height:130)
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = UIColor.red
        imageView.layer.cornerRadius = 40.0
        self.view.addSubview(imageView)

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture(tap:)))
        imageView.addGestureRecognizer(tap)
}
    
    func tapGesture(tap:UITapGestureRecognizer)
    {
        let aleat = UIAlertController(title: "照片选择", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        weak var weakSelf = self;
        let aleartAction = UIAlertAction(title: "相册", style: UIAlertActionStyle.default) { (_) -> Void in
            self.imageVC.sourceType = UIImagePickerControllerSourceType.photoLibrary
            weakSelf!.present(self.imageVC, animated: true, completion: nil);
        }
        let aleartAction_cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (_) -> Void in
            
        }
        aleat.addAction(aleartAction);
        aleat.addAction(aleartAction_cancel);
        self.present(aleat, animated: true, completion: nil);

    }
    //懒加载创建imageVC
    private lazy var imageVC:UIImagePickerController = {
        let imageVc = UIImagePickerController()
        imageVc.delegate = self
        return imageVc;
    }()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //获取url和image

        print("提交测试")
        let image = info["UIImagePickerControllerOriginalImage"] as? UIImage
        dataofSelfIntro = UIImagePNGRepresentation(image!)!
        
        //
        let netInstance=iconNetworking()
        netInstance.uploadImageWithImage(dataofSelfIntro!)
        
        
        print("dataofselfIntro复制完成")
        let imageView = UIImageView()
        imageView.image = image
        imageView.frame = CGRect(x:180, y:220, width:130, height:130)
        view.addSubview(imageView)
        dismiss(animated: true, completion: nil)
    }


    @objc func imAction() -> Void {
        print("图片点击事件")
    }
    func textDidChange(_ textField:UITextField) -> Bool {
        print(textField.text)
        newloginName=textField.text!
        return true
    }
    func TextDidChange(_ textField:UITextField) -> Bool {
        
        print(textField.text)
        newintroduce=textField.text!
        return true
    }
    @objc func buttonTapped(sender: UIButton)
    {
        if ((loginName==newloginName)&&(introduce==newintroduce)) {}
        else{
            loginName=newloginName;introduce=newintroduce
            print("xxxxxxxxxxxxxxxxx",Jsonaddress)
            let loginNamecheck = ["username": newloginName,"description": newintroduce,"id":id,"profilePic":Jsonaddress]
            NetworkTools.shardTools.request(method: .Post, urlString: "http://192.168.253.7:8000/board/update", parameters: loginNamecheck as AnyObject?)
            { (responseObject, error) in
                if error != nil {print(error!);return}
                guard (responseObject as? [String : AnyObject]) != nil else{return}
                print(responseObject!)
                let jsonStr = responseObject as! [String: AnyObject]
                let user = jsonStr["flag"]
                print (user)
                self.response=user as! String
                if self.response=="1" {print("修改成功")}
                else {print("修改不成功")}
            }
            let detail=Mesboard()
            self.navigationController!.pushViewController(detail, animated: true)

            let alertController2 = UIAlertController(title: "状态提示", message: "保存成功返回留言板",preferredStyle: .alert)
            let cancelAction1 = UIAlertAction(title: "确定", style: .destructive, handler: nil)
            alertController2.addAction(cancelAction1)
            self.present(alertController2, animated: true, completion: nil)
            print("修改后的登录名是：",loginName,"修改后的简介是",introduce)
    }
       }
    
}
