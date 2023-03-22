//
//  Date+Extension.swift
//  lib_basic
//
//  Created by 陶博 on 2022/11/1.
//  Copyright © 2022 lubansoft. All rights reserved.
//

import Foundation

public extension Date {
    /// 获取时间的字符串
    /// - Parameter format: 时间的格式 eg:"yyyy-mm-dd"
    /// yyyy.MM.dd HH:mm:ss EEE
    /// yyyy 年   MM月  dd日  HH 时 mm分 ss秒  EEE 周几
    /// - Returns: 时间的string
    static func getCurrentShortDate(format: String) -> String {
        let todaysDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: todaysDate as Date)
        return dateString
        
    }
}

