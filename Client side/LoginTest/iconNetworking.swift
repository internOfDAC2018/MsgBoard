import Foundation


class iconNetworking: NSObject {
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
                Jsonaddress = jsonStr["pic"] as! String
                print("成功回调：",Jsonaddress)
            },
            failure: { (task, error) in print(error)}
        )
        
        
    }
}
