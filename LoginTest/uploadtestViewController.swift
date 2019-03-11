import UIKit
class uploadtestViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate
{
    func tapGesture(tap:UITapGestureRecognizer) {
    let aleat = UIAlertController(title: "照片选择", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
    weak var weakSelf = self;
    let aleartAction = UIAlertAction(title: "相册", style: UIAlertActionStyle.default) { (_) -> Void in
            self.imageVC.sourceType = UIImagePickerControllerSourceType.photoLibrary
            weakSelf!.present(self.imageVC, animated: true, completion: nil);
        print("A")
            
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
    
    // 选择完成图片后调用的方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //获取url和image
        let imageUrl = info["UIImagePickerControllerReferenceURL"] as? NSURL
        let image = info["UIImagePickerControllerOriginalImage"] as? UIImage
        let data = UIImagePNGRepresentation(image!)
   // 格式不正确 UIImagePickerController没有对应的NsData的方法，UIImage转换为NsData不成功
        //let image2 = info["UIImagePickerControllerOriginalImage"] as? NSData
        let abcd=YJRequest()
        abcd.uploadImageWithImage(data!)

        print("imageUrl:",imageUrl,"and  image:",image)
       
 
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.frame = CGRect(x:100,y:100,width:200,height:100)
//        imageView.layer.masksToBounds = true
//        imageView.layer.cornerRadius = 40.0
        view.addSubview(imageView)
        dismiss(animated: true, completion: nil)
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(frame: CGRect(x:200, y:400, width:100, height:100))
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = UIColor.yellow
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 40.0
        view.addSubview(imageView)
        
        //添加手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(uploadtestViewController.tapGesture(tap:)))
        tap.delegate = self
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(tap)
    }
    
    }

