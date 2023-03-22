//
//  UIButton+Extension.swift
//  lib_basic
//
//  Created by 陶博 on 2021/7/13.
//  Copyright © 2021 lubansoft. All rights reserved.
//

import Foundation
import UIKit

public enum ButtonEdgeInsetsStyle {
    ///  image在上，label在下
    case ButtonEdgeInsetsStyleTop
    /// image在左，label在右
    case ButtonEdgeInsetsStyleLeft
    /// image在下，label在上
    case ButtonEdgeInsetsStyleBottom
    /// image在右，label在左
    case ButtonEdgeInsetsStyleRight
}

public extension UIButton {
    func layoutButtonEdgeInsets(style:ButtonEdgeInsetsStyle,space:CGFloat) {
        self.sizeToFit()
        var labelWidth : CGFloat = 0.0
        var labelHeight : CGFloat = 0.0
        var imageEdgeInset = UIEdgeInsets.zero
        var labelEdgeInset = UIEdgeInsets.zero
        let imageWith = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        let systemVersion = UIDevice.current.systemVersion
        if (Double(systemVersion) ?? 0.0) >= 8.0 {
            labelWidth = (self.titleLabel?.intrinsicContentSize.width)!
            labelHeight = (self.titleLabel?.intrinsicContentSize.height)!
        }else {
            labelWidth = (self.titleLabel?.frame.size.width)!
            labelHeight = (self.titleLabel?.frame.size.height)!
        }
//        labelWidth = CGFloat(36)
        switch style {
        case .ButtonEdgeInsetsStyleTop:
            imageEdgeInset = UIEdgeInsets(top: -labelHeight-space/2.0, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInset = UIEdgeInsets(top: 0, left: -imageWith!, bottom: -imageHeight!-space/2.0, right: 0)
        case .ButtonEdgeInsetsStyleLeft:
            imageEdgeInset = UIEdgeInsets(top: 0, left: -space/2.0, bottom: 0, right: space/2.0)
            labelEdgeInset = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2.0)
        case .ButtonEdgeInsetsStyleBottom:
            imageEdgeInset = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight-space/2.0, right: -labelWidth)
            labelEdgeInset = UIEdgeInsets(top: -imageHeight!-space/2.0, left: -imageWith!, bottom: 0, right: 0)
        case .ButtonEdgeInsetsStyleRight:
            imageEdgeInset = UIEdgeInsets(top: 0, left: labelWidth+space/2.0, bottom: 0, right: -labelWidth-space/2.0)
            labelEdgeInset = UIEdgeInsets(top: 0, left: -imageWith!-space/2.0, bottom: 0, right: imageWith!+space/2.0)
        }
        self.titleEdgeInsets = labelEdgeInset
        self.imageEdgeInsets = imageEdgeInset
    }
}
