//
//  LBRequestHelper.swift
//  lib_common
//
//  Created by 陶博 on 2021/6/25.
//  Copyright © 2021 lubansoft. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import RxSwift
import HandyJSON

// moya请求post时body中传单纯的数组需要把数组放到dic中的ios_array键中
public let POST_ARRAY_KEY = "ios_array"

/// 服务器名称
public enum LBServiceName : String {
    case lubanDataManage = "luban-data-manage"
    case authServer = "auth-server"
    
}

/// 网路请求返回的状态码
public enum ResponseCodeType : Int,HandyJSONEnum {
    /// 网络错误
    case code404 = 404
    /// token失效  退出登录
    case code1007 = 1007
    /// 用户被踢出  退出登录
    case code1002 = 1002
    /// 用户登录错误
    case code1021 = 1021
    /// 未匹配选择器
    case code_107 = -107
    /// 没有数据
    case code_204 = 204
    /// 服务器异常
    case code_500 = 500
    /// 请求成功
    case codeSuccess = 200
}

public class LBRequestHelper: NSObject {
    public static let share = LBRequestHelper()
    required override init() {}
    
    /// 请求头配置
    /// - Returns: dict
    public func headers() -> [String: String] {
        var dic:[String: String] = [String: String]()
        let token = ""
        dic = ["access-token": token,"Accept": "application/json"]
        return dic
    }
    
    /// baseURL
    /// - Returns: string
    public func baseURL() -> String {
        return "baseURL"
    }
    
    /// 融云相关的baseURL
    /// - Returns: url
    public func lubanIMAPServerbaseURL() -> String {
        return "lubanIMAPServerbaseURL"
    }
    
    
    /// 获取返回状态码
    /// - Parameters:
    ///   - code: 状态码
    ///   - msg: 状态信息
    public func handleReponseCode(_ code: Int, _ msg: String) {
        guard let responseCodeType = ResponseCodeType.init(rawValue: code) else {return}
        switch responseCodeType {
        case .code404:
//            LBHUD.showAlertView("网络错误")
            break
        case .code1002,.code1007,.code_107,.code_500:
            if !msg.isEmpty {
//                LBHUD.showAlertView(msg)
            }
            break
        default:
            break
        }
    }
}


//MARK:-- 请求的插件
public class Plugin: NSObject, PluginType {
    public func willSend(_ request: RequestType, target: TargetType) {
        //        debugPrint("开始发送")
        //        DispatchQueue.main.async {
        //            LBHUD.showLaoding()
        //        }
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        // 获取请求状态码
        switch result {
        case .success(let responnse):
            if let jsonString = try? responnse.mapString() {
                let responseModel = LBBaseResponse.deserialize(from: jsonString)
                // 提示错误信息
                LBRequestHelper.share.handleReponseCode(responnse.statusCode, responseModel?.message ?? "")
            }
            break
        case .failure(let error):
            LBRequestHelper.share.handleReponseCode(error.errorCode, error.localizedDescription)
            debugPrint(error)
            break
        }
        //        debugPrint("请求结束")
        
        //        DispatchQueue.main.async {
        //            LBHUD.hide()
        //        }
    }
    
    /// 处理请求内容
    /// - Parameters:
    ///   - request: request
    ///   - target: target
    /// - Returns: request
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var moyaQequest = request
        moyaQequest.timeoutInterval = 20//请求超时时间
        return moyaQequest
    }
    
    public func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        return result
    }
}

//MARK:-- 对RXSwift的ObservableType进行扩展
public extension ObservableType where Element == Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(response.mapModel(T.self))
        }
    }
}
//MARK:-- 对Response扩展
public extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) -> T {
        let jsonString = String.init(data: data, encoding: .utf8)
        return JSONDeserializer<T>.deserializeFrom(json: jsonString) ?? T.init()
    }
}


public class DisposeBagHepler {
    public static let share = DisposeBagHepler()
    public required init() {}
    public let disposeBag = DisposeBag()
}


/// 解决moyaPOST方法body中不能直接传数组的问题
/// eg: return .requestParameters(parameters: ["ios_array": ["Yes", "What", "abc"]], encoding: JSONArrayEncoding.default)
public struct JSONArrayEncoding: ParameterEncoding {
    public static let `default` = JSONArrayEncoding()
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        guard let json = parameters?[POST_ARRAY_KEY] else {
            return request
        }
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        request.httpBody = data
        return request
    }
}

/// 解决moyaGET方法中不能直接传数组的问题
public struct BracketLessGetEncoding: ParameterEncoding {
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try URLEncoding().encode(urlRequest, with: parameters)
        request.url = URL(string: request.url!.absoluteString.replacingOccurrences(of: "%5B%5D=", with: "="))
        return request
    }
}

