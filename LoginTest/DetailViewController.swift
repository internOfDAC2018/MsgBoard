import UIKit
class DetailViewController:UIViewController, UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate
{
       var dataofDetail:Data?
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
}
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let url=URL(string: mybaseaddress+Jsonaddress)
        //从网络获取数据流
        let data = try!Data(contentsOf: url!)
        //通过数据流初始化图片
        let newImage=UIImage(data: data)
        let imageView=UIImageView(image:newImage);
        imageView.frame = CGRect(x:20, y:70, width:50, height:50)
        self.view.addSubview(imageView)
        let Nicklabel = UILabel(frame: CGRect(x: 80, y: 70, width: 100, height: 30))
        Nicklabel.text = "昵称："
        Nicklabel.textColor = UIColor.black
        self.view.addSubview(Nicklabel)
        
        
        let UserNamelabel = UILabel(frame: CGRect(x: 130, y: 70, width: 100, height: 30))
        UserNamelabel.text = loginName
        UserNamelabel.textColor = UIColor.black
        self.view.addSubview(UserNamelabel)
        
        
        let introduction = UILabel(frame: CGRect(x: 80, y: 90, width: 100, height: 30))
        introduction.text = "简介："
        introduction.textColor = UIColor.black
        self.view.addSubview(introduction)
        
        
        let introducelabel = UILabel(frame: CGRect(x: 120, y: 90, width: 200, height: 30))
        introducelabel.text = introduce
        introducelabel.textColor = UIColor.black
        self.view.addSubview(introducelabel)
        
        
        let frame = CGRect(x: 0, y: 125, width: 400, height: 100)
        let cgView = CGView(frame: frame)
        self.view.addSubview(cgView)
        let button = UIButton(frame: CGRect(x: 250, y: 70, width: 200, height: 30))
        button.setTitle("个人主页>>", for: .normal)
        button.setTitleColor(UIColor.gray, for: UIControlState.normal)
        button.setTitleShadowColor(UIColor.green, for:.normal)
        button.backgroundColor=UIColor.white
        button.addTarget(self, action: #selector(self.EnterselfintorPage(sender:)), for: .touchUpInside)
        view.addSubview(button)
        let friendgroup = UIButton(frame: CGRect(x: 250, y: 95, width: 200, height: 30))
        friendgroup.setTitle("进入留言板>>", for: .normal)
        friendgroup.setTitleColor(UIColor.gray, for: UIControlState.normal)
        friendgroup.setTitleShadowColor(UIColor.green, for:.normal)
        friendgroup.backgroundColor=UIColor.white
        friendgroup.addTarget(self, action: #selector(self.test(sender:)), for: .touchUpInside)
        view.addSubview(friendgroup)
        
        let infoLabel = UILabel(frame: CGRect(x: 10, y: 150, width: 200, height: 30))
        infoLabel.text="在此处记载你的留言内容"
        infoLabel.numberOfLines=0
        infoLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        infoLabel.textColor = UIColor.black
        infoLabel.font = UIFont .systemFont(ofSize: 16)
        self.view.addSubview(infoLabel)
        
        let submit = UIButton(frame: CGRect(x: 10, y: 450, width: 390, height: 30))
        submit.setTitle("提交留言", for: .normal)
        submit.setTitleColor(UIColor.red, for: UIControlState.normal)
        submit.setTitleShadowColor(UIColor.green, for:.normal)
        submit.backgroundColor=UIColor.yellow
        submit.addTarget(self, action: #selector(self.message(sender:)), for: .touchUpInside)
        view.addSubview(submit)
        
        let Preview = UILabel(frame: CGRect(x: 15, y: 360, width: 100, height: 30))
        Preview.text="图片预览"
        Preview.numberOfLines=0
        Preview.lineBreakMode = NSLineBreakMode.byWordWrapping
        Preview.textColor = UIColor.black
        Preview.font = UIFont .systemFont(ofSize: 16)
        self.view.addSubview(Preview)

        let Choseimage = UIButton(frame: CGRect(x:260, y:150, width:160, height:30))
        Choseimage.setTitle("点击选择图片>>", for: .normal)
        Choseimage.setTitleColor(UIColor.gray, for: UIControlState.normal)
        Choseimage.setTitleShadowColor(UIColor.green, for:.normal)
        Choseimage.backgroundColor=UIColor.white
        Choseimage.addTarget(self, action: #selector(DetailViewController.tapGesture(tap:)), for: .touchUpInside)
        view.addSubview(Choseimage)


        let textView = UITextView(frame:CGRect(x: 10, y: 180, width: 390, height: 130))
        textView.backgroundColor = UIColor.lightGray        //添加到视图上
        self.view.addSubview(textView)
        textView.textColor = UIColor.black
        textView.font = UIFont.systemFont(ofSize: 18);//使用系统默认字体，指定14号字号
        textView.textAlignment = .left
        textView.delegate = self
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.linkTextAttributes = [NSForegroundColorAttributeName: UIColor.orange,
                                       NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
           }
    
    
    func tapGesture(tap:UITapGestureRecognizer) {
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
    
    // 选完图片后调用的方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //获取url和image
        print("提交测试")
        let image = info["UIImagePickerControllerOriginalImage"] as? UIImage
        dataofDetail = UIImagePNGRepresentation(image!)!
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.frame = CGRect(x:100,y:320,width:200,height:100)
        view.addSubview(imageView)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func EnterselfintorPage(sender: UIButton) {
        print("进入个人主页")
        let selfintroPage=SelfIntroViewController()
        self.navigationController!.pushViewController(selfintroPage, animated: true)
    }
    @objc func test(sender: UIButton) {
        print("进入下拉页面测试")
        let test=Mesboard()
        self.navigationController!.pushViewController(test, animated: true)
    }
    @objc func message(sender: UIButton) {
        let abcd3f=YJRequest()
        abcd3f.uploadImageWithImage(dataofDetail!)
        print("发送的内容是：",MESSAGE,"图片名为：",Pic)
        let alertController2 = UIAlertController(title: "状态提示", message: "留言成功",preferredStyle: .alert)
        let cancelAction1 = UIAlertAction(title: "确定", style: .destructive, handler: nil)
        alertController2.addAction(cancelAction1)
        self.present(alertController2, animated: true, completion: nil)

    }
    func textViewDidChange(_ textView: UITextView) {
        MESSAGE=textView.text
        print(MESSAGE)
    }

}
