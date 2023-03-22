//
//  Dictionary+Extension.swift
//  lib_basic
//
//  Created by 陶博 on 2021/6/26.
//  Copyright © 2021 lubansoft. All rights reserved.
//

import Foundation

// MARK: 字典转字符串
extension Dictionary {
    public func toJsonString() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self,
                                                     options: []) else {
            return nil
        }
        guard let str = String(data: data, encoding: .utf8) else {
            return nil
        }
        return str
     }
    
    
    public func AnyHashableTypeConversionStringType(_ anyHashableDic: [AnyHashable: Any]) -> [String: Any] {
        let userInfoString = anyHashableDic.toJsonString()
        let userInfoDic = userInfoString?.toDictionary()
        if let dic = userInfoDic {
            return dic
        }else{
            return [:]
        }
     }
    
}
