//  NewworkingTools.swift
//  Created by 吴以恒 on 2019/2/21.
//  Copyright © 2019年 WuYiheng. All rights reserved.

import Foundation
import UIKit
enum HTResqustMethod : String {
    case Post = "post"
    case Get = "get"
}
enum MyBool {
    case myTrue, myFalse
}
class NetworkTools: AFHTTPSessionManager {

    static let shardTools : NetworkTools = {
        let tools = NetworkTools()
        tools.requestSerializer = AFJSONRequestSerializer.init()
        return tools
    }()
func request(method: HTResqustMethod , urlString: String, parameters: AnyObject?,resultBlock : @escaping([String : Any]?, Error?) -> ()){
        // 定义一个请求成功之后要执行的闭包
        // 成功闭包
        let successBlock = { (task: URLSessionDataTask, responseObj: Any?) in
            resultBlock(responseObj as? [String : Any], nil)
        }
        // 失败的闭包
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            resultBlock(nil, error)
        }
        // Get 请求
        if method == .Get {
            get(urlString, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        // Post 请求
        if method == .Post {
            post(urlString, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
            print("执行了post请求")
        }
    }
}
