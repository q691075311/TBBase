//
//  Array+Extension.swift
//  lib_basic
//
//  Created by 陶博 on 2021/6/29.
//  Copyright © 2021 lubansoft. All rights reserved.
//

import Foundation
import UIKit

public protocol Copyable {
    func copy() -> Self
}

public extension Array where Element: Copyable{
    func copy() -> Self {
        var arr = [Element]()
        self.forEach { (item: Copyable) in
            let e: Element = item.copy() as! Element
            arr.append(e)
        }
        return arr
    }
    
}

public extension Array where Self.Element == String {
    func toJson() -> String {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("无法解析出JSONString")
            return ""
        }
        if let data = try? JSONSerialization.data(withJSONObject: self, options:[.withoutEscapingSlashes]), let JSONString = String(data: data, encoding: .utf8) {
            return JSONString
        }
        return ""
    }
}

