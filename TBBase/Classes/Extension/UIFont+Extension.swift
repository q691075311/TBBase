//
//  UIFont+Extension.swift
//  vipSing
//
//  Created by Norman on 2020/11/12.
//  Copyright © 2020 iClass. All rights reserved.
//

import UIKit

public extension UIFont {
    
    enum FontType: String {
        /// 常规
        case Regular
        /// 中黑
        case Medium
        /// 中粗
        case Semibold
    }
    
    static func pingFang(_ fontType: FontType, _ size: CGFloat = 16) -> UIFont {
        return UIFont(name: "PingFangSC-" + fontType.rawValue, size: size)!
    }
}
