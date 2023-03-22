//
//  PSYDefinition.swift
//  FerrisWheel
//
//  Created by lizhongqiang on 2021/5/19.
//

import Foundation
import UIKit

/// 设备宽度
public let screenWidth = UIScreen.main.bounds.size.width
/// 设备高度
public let screenHeight = UIScreen.main.bounds.size.height

/// 状态栏的高度 全面屏是44  非全面屏是20
public var navigationBarSafeTopMargin: CGFloat {
    return UIScreen.isFullScreen ? 44 : 20
}

/// 导航栏的高度 全面屏是88  非全面屏是64
public var navigationBarHeight: CGFloat {
    return UIScreen.isFullScreen ? 88 : 64
}

/// 底部TabBar的高度  全面屏34  非全面屏0
public var tabbatSafeHeight: CGFloat {
    return UIScreen.isFullScreen ? 34 : 0
}

public extension UIScreen{
    /// 是否是全面屏
    static var isFullScreen: Bool {
        if #available(iOS 11, *) {
            let bottomSafeAreaHeight =  UIApplication.shared.windows.last?.safeAreaInsets.bottom ?? 0.0;
              if bottomSafeAreaHeight > 0 {
                  return true
              }
        }
        return false
    }
}






