import Foundation


class YJRequest: NSObject {
    func uploadImageWithImage(_ imageData: Data){
        print("C")
        let sessionConfiguration = URLSessionConfiguration.default
        let manager =  AFHTTPSessionManager(sessionConfiguration: sessionConfiguration)
        manager.responseSerializer.acceptableContentTypes = NSSet(arrayLiteral: "application/json", "text/json", "text/javascript","text/html","multipart/form-data") as? Set<String>
        
        
        
        manager.post(
            "http://192.168.253.7:8000/board/upload",
            
            parameters: ["":""],
            
            constructingBodyWith:
            {
                (file) in
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                formatter.timeZone = NSTimeZone.system
                let fileName:String = "\(formatter.string(from: NSDate.init() as Date)).jpg"
                print("fileName is:",fileName)
                file.appendPart(withFileData: imageData, name: "file", fileName: "fileName.png", mimeType: "image/png")
            },
            progress: { (progress) in},
            success: { (task, response) in print(response)
                let jsonStr = response as! [String: AnyObject]
                Pic = jsonStr["pic"] as! String
                print("回调的文件名是：",Pic)
                print("AAAAA发送的内容是：",MESSAGE,"AAAAA图片名为：",Pic)
                let params = ["content": MESSAGE, "pic":Pic]
                NetworkTools.shardTools.request(method: .Post, urlString: "http://192.168.253.7:8000/board/addone", parameters: params as AnyObject?)
                { (responseObject, error) in
                    if error != nil {print(error!);return}
                    guard (responseObject as? [String : AnyObject]) != nil else{return}
                    print(responseObject!)
                    let jsonStr = responseObject as! [String: AnyObject]
                     let flag = jsonStr["flag"] as! String
                    if flag=="1" {print("可以了")}
                    else {print("还不可以")}
                }

            },
            failure: { (task, error) in print(error)}
        )
        
        
    }
}
