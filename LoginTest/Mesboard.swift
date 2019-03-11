import UIKit
let startPage = 1
import WebKit
var String1=""
var String2=""
class Mesboard:UIViewController,UITableViewDataSource,UITableViewDelegate {
    var activityIndicator:UIActivityIndicatorView!
    lazy var wkWebView = WKWebView()
    var content = [String](arrayLiteral: "abc","","","","","","","","","","","")
    var publishtime = [String](arrayLiteral: "","","","","","","","","","","","")
    var userName = [String](arrayLiteral: "","","","","","","","","","","","")
    var picaddress=[String](arrayLiteral: "","","","","","","","","","","","")
    var profileaddress=[String](arrayLiteral: "","","","","","","","","","","","")
    var dataSource = [[String:String]()]
    var scrollView:UIScrollView?
    var lastImageView:UIImageView?
    var originalFrame:CGRect!
    var isDoubleTap:ObjCBool!
    let NetWorkActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle:.gray)
    @IBOutlet weak var myImageView: UIImageView!

        override func viewDidLoad() {
        super.viewDidLoad()
            view.addSubview(NetWorkActivityIndicatorView)
            NetWorkActivityIndicatorView.hidesWhenStopped = true
            NetWorkActivityIndicatorView.startAnimating()
            let tableView = UITableView(frame: view.bounds, style: .grouped)
            print(view.bounds)
            tableView.backgroundColor = UIColor.white;
            view.addSubview(tableView)
            tableView.dataSource = self
            tableView.delegate = self

            
        let params = ["startPage": startPage]
        NetworkTools.shardTools.request(method: .Post, urlString: "http://192.168.253.7:8000/board/msg", parameters: params as AnyObject?)
                { (responseObject, error) in
                    if error != nil {print(error!);return}
                    guard (responseObject as? [String : AnyObject]) != nil else{return}
                    //print(responseObject!)
                    //JSON解析部分
                let jsonStr = responseObject as! [String: AnyObject]
                let message = jsonStr["msgs"]
                let json = JSON(parseJSON: message)
//                let content0=json[0]["content"].stringValue
                    
                for index in 0 ..< 12 {
                    self.content[index] = json[index]["content"].stringValue
//                print("第",index+1,"组的content是：",self.content[index])
                self.publishtime[index] = json[index]["date"].stringValue
//                print("第",index+1,"组的publishtime是：",self.publishtime[index])
                self.userName[index] = json[index]["username"].stringValue
//                print("第",index+1,"组的userName是：",self.userName[index])
                self.picaddress[index] = mybaseaddress+json[index]["pic"].stringValue
                    print("第",index+1,"组的picaddress是：",self.picaddress[index])
                self.profileaddress[index] = mybaseaddress+json[index]["profilePic"].stringValue
                    print("第",index+1,"组的profileaddress是：",self.profileaddress[index])

                }

                    
                    self.dataSource = [
["loginName":self.userName[0],"publishTime":self.publishtime[0],"icon":self.profileaddress[0],"content":self.content[0],"picture":self.picaddress[0]],
["loginName":self.userName[1],"publishTime":self.publishtime[1],"icon":self.profileaddress[1],"content":self.content[1],"picture":self.picaddress[1]],
["loginName":self.userName[2],"publishTime":self.publishtime[2],"icon":self.profileaddress[2],"content":self.content[2],"picture":self.picaddress[2]],
["loginName":self.userName[3],"publishTime":self.publishtime[3],"icon":self.profileaddress[3],"content":self.content[3],"picture":self.picaddress[3]],
["loginName":self.userName[4],"publishTime":self.publishtime[4],"icon":self.profileaddress[4],"content":self.content[4],"picture":self.picaddress[4]],
["loginName":self.userName[5],"publishTime":self.publishtime[5],"icon":self.profileaddress[5],"content":self.content[5],"picture":self.picaddress[5]],
["loginName":self.userName[6],"publishTime":self.publishtime[6],"icon":self.profileaddress[6],"content":self.content[6],"picture":self.picaddress[6]],
["loginName":self.userName[7],"publishTime":self.publishtime[7],"icon":self.profileaddress[7],"content":self.content[7],"picture":self.picaddress[7]],
["loginName":self.userName[8],"publishTime":self.publishtime[8],"icon":self.profileaddress[8],"content":self.content[8],"picture":self.picaddress[8]],
["loginName":self.userName[9],"publishTime":self.publishtime[9],"icon":self.profileaddress[9],"content":self.content[9],"picture":self.picaddress[9]],
["loginName":self.userName[10],"publishTime":self.publishtime[10],"icon":self.profileaddress[10],"content":self.content[10],"picture":self.picaddress[10]],
["loginName":self.userName[11],"publishTime":self.publishtime[11],"icon":self.profileaddress[11],"content":self.content[11],"picture":self.picaddress[11]],
                    ]
                     tableView.reloadData()
                    
                    
        }

            let url2=URL(string:"https://ss1.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1612888718,2770817803&fm=26&gp=0.jpg")
            let data2 = try!Data(contentsOf: url2!)
            let newImage2=UIImage(data: data2)
            let imageView2=UIImageView(image:newImage2);
            imageView2.frame = CGRect(x:0, y:0, width:400, height:130)
            self.view.addSubview(imageView2)

            //图层叠加测试
            
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
            
            
            let Introduction = UILabel(frame: CGRect(x: 80, y: 90, width: 100, height: 30))
            Introduction.text = "简介："
            Introduction.textColor = UIColor.black
            self.view.addSubview(Introduction)
            let Introducelabel = UILabel(frame: CGRect(x: 120, y: 90, width: 200, height: 30))
            Introducelabel.text = introduce
            Introducelabel.textColor = UIColor.black
            self.view.addSubview(Introducelabel)
            
            let friendgroup = UIButton(frame: CGRect(x: 250, y: 95, width: 200, height: 30))
            friendgroup.setTitle("留言区域>>", for: .normal)
            friendgroup.setTitleColor(UIColor.gray, for: UIControlState.normal)
            friendgroup.setTitleShadowColor(UIColor.green, for:.normal)
            friendgroup.backgroundColor=UIColor.white
            friendgroup.addTarget(self, action: #selector(self.test(sender:)), for: .touchUpInside)
            view.addSubview(friendgroup)
            
            let button = UIButton(frame: CGRect(x: 250, y: 70, width: 200, height: 30))
            button.setTitle("个人主页>>", for: .normal)
            button.setTitleColor(UIColor.gray, for: UIControlState.normal)
            button.setTitleShadowColor(UIColor.green, for:.normal)
            button.backgroundColor=UIColor.white
            button.addTarget(self, action: #selector(self.EnterselfintorPage(sender:)), for: .touchUpInside)
            view.addSubview(button)
            
    }
    //MARK: UITableViewDataSource
    // cell的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    // UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "testCellID"
        var cell:NewTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellid) as? NewTableViewCell
        if cell==nil {
            cell = NewTableViewCell(style: .subtitle, reuseIdentifier: cellid)
        }
        let dict:Dictionary = dataSource[indexPath.row]
        if dict.count > 0 {

            let data = try!Data(contentsOf: URL(string: dict["icon"]!)!)
            cell?.iconImv.image = UIImage(data:data)
            
            let dataofpicture = try!Data(contentsOf: URL(string: dict["picture"]!)!)
            cell?.picture.image = UIImage(data:dataofpicture)
            
            cell?.loginName.text = dict["loginName"]
            cell?.publishTime.text = dict["publishTime"]
            cell?.content.text = dict["content"]
            print("B")
        }
    self.NetWorkActivityIndicatorView.stopAnimating()
        return cell!
    }
    
    //MARK: UITableViewDelegate
    // 设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    //设置表单到顶部的距离
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 125
    }
    // 选中cell后执行此方法
    
    @objc func EnterselfintorPage(sender: UIButton) {
        print("进入个人主页")
        let selfintroPage=SelfIntroViewController()
        self.navigationController!.pushViewController(selfintroPage, animated: true)
    }
    @objc func test(sender: UIButton) {
        print("留言区")
        let test=DetailViewController()
        self.navigationController!.pushViewController(test, animated: true)
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let bgView = UIScrollView.init(frame: UIScreen.main.bounds)
        bgView.backgroundColor = UIColor.black
        let tapBg = UITapGestureRecognizer.init(target: self, action: #selector(tapBgView(tapBgRecognizer:)))
        bgView.addGestureRecognizer(tapBg)
        
        
        let index = self.picaddress[indexPath.row].characters.index(of: "_")
        if let index = index {
            let subStr = self.picaddress[indexPath.row].substring(to: index)
            String1=subStr
            print(String1)
        }
        let url=URL(string: String1+".png")
        let data = try!Data(contentsOf: url!)
        let newImage=UIImage(data: data)
        let picView=UIImageView(image:newImage);
        let imageView = UIImageView.init()
        imageView.image = picView.image;
        imageView.frame = bgView.convert(picView.frame, from: self.view)
        bgView.addSubview(imageView)
        UIApplication.shared.keyWindow?.addSubview(bgView)
        self.lastImageView = imageView
        self.originalFrame = imageView.frame
        self.scrollView = bgView
        self.scrollView?.maximumZoomScale = 1.5
        self.scrollView?.delegate = self

        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: UIViewAnimationOptions.beginFromCurrentState,
            animations: {
                var frame = imageView.frame
                frame.size.width = bgView.frame.size.width
                frame.size.height = frame.size.width * ((imageView.image?.size.height)! / (imageView.image?.size.width)!)
                frame.origin.x = 0
                frame.origin.y = (bgView.frame.size.height - frame.size.height) * 0.5
                imageView.frame = frame
            }, completion: nil
        )
    }
    func tapBgView(tapBgRecognizer:UITapGestureRecognizer)
    {
        self.scrollView?.contentOffset = CGPoint.zero
        UIView.animate(withDuration: 0.5, animations: {
            self.lastImageView?.frame = self.originalFrame
            tapBgRecognizer.view?.backgroundColor = UIColor.clear
        }) { (finished:Bool) in
            tapBgRecognizer.view?.removeFromSuperview()
            self.scrollView = nil
            self.lastImageView = nil
        }
    }
    
    //正确代理回调方法
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.lastImageView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//
//
//override func viewWillAppear(_ animated: Bool) {
//    
//}
//
//override func viewDidAppear(_ animated: Bool) {
//    
//}
//
//override func viewWillDisappear(_ animated: Bool) {
//    
//}
//
//override func viewDidDisappear(_ animated: Bool) {
//    
//}
