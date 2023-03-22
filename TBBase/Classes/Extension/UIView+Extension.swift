//
//  UIView+Extension.swift
//  lib_basic
//
//  Created by 陶博 on 2021/7/6.
//  Copyright © 2021 lubansoft. All rights reserved.
//

import Foundation
import UIKit

public extension UIView{
    
    /// 添加view
    /// - Parameter views: views
    func addSubViews(_ views: [UIView]) {
        for item in views {
            addSubview(item)
        }
    }
    
    /// 找到view所在的vc
    /// - Returns: vc
    func viewController() -> UIViewController?{
        for view in sequence(first: self.superview, next: {$0?.superview}){
            if let responder = view?.next{
                if responder.isKind(of: UIViewController.self){
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    
    /// 设置圆角
    /// - Parameter value: 圆角大小
    func roundCorners(_ value: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = value
    }
    
}
