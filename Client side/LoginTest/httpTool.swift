//  httpTool.swift
//  LoginTest
//  Copyright © 2019年 WuYiheng. All rights reserved.
import Foundation
import UIKit
import AFNetworking

//枚举定义请求方式
enum HTTPRequestType {
    case GET
    case POST
}

class NetworkManager: AFHTTPSessionManager {
    
    //单例
    static let shared = NetworkManager()
    
    /// 封装GET和POST 请求
    ///
    /// - Parameters:
    ///   - requestType: 请求方式
    ///   - urlString: urlString
    ///   - parameters: 字典参数
    ///   - completion: 回调
    func request(requestType: HTTPRequestType, urlString: String, parameters: [String: AnyObject]?, completion: @escaping (AnyObject?) -> ()) {
        
        //成功回调
        let success = { (task: URLSessionDataTask, json: Any)->() in
            completion(json as AnyObject?)
        }
        
        //失败回调
        let failure = { (task: URLSessionDataTask?, error: Error) -> () in
            print("网络请求错误 \(error)")
            completion(nil)
        }
        
        if requestType == .GET {
            get(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        } else {
            post(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
}



NetworkManager.shared.request(requestType: .GET, urlString: "https:www.baidu.com", parameters: ["userName": "zhangsan" as AnyObject]) { (json) in
    print(json)
}
