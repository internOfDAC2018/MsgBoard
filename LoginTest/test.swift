//import UIKit
//import WebKit
//class test: UIViewController ,UIScrollViewDelegate {
//    var activityIndicator:UIActivityIndicatorView!
//    lazy var wkWebView = WKWebView()
//       override func viewDidLoad() {
//        let NetWorkActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle:.whiteLarge)
//        view.addSubview(NetWorkActivityIndicatorView)
//        
//        let bigger = UIButton(frame: CGRect(x: 100, y: 150, width: 100, height: 130))
//        bigger.setTitle("测试全屏预览", for: .normal)
//        bigger.setTitleColor(UIColor.red, for: UIControlState.normal)
//        bigger.setTitleShadowColor(UIColor.green, for:.normal)
//        bigger.backgroundColor=UIColor.yellow
//        bigger.addTarget(self, action: #selector(self.biggertest(sender:)), for: .touchUpInside)
//        view.addSubview(bigger)
//    }
//    func initInterface() -> () {
//        self.wkWebView.frame = CGRect(x: 0, y: 0, width: 400, height: 700)
//        let url = URL(string: "https://www.cnblogs.com/ZGSmile/p/5694581.html")
//        let request = URLRequest(url: url!)
//        wkWebView.navigationDelegate = self
//        wkWebView.load(request)
//    }
//   }
//extension test: WKNavigationDelegate
//{
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        print( "开始加载...")
//        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.gray)
//        self.activityIndicator.center = self.view.center
//        self.view.addSubview(self.activityIndicator)
//        self.activityIndicator.startAnimating()
//    }
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
//        print("页面加载完成...")
//        self.activityIndicator.stopAnimating()
//           }
//}
//
//@objc func biggertest(sender: UIButton)
//{
//    self.NetWorkActivityIndicatorView.hidesWhenStopped = true
//    self.NetWorkActivityIndicatorView.startAnimating()
//
//    }
