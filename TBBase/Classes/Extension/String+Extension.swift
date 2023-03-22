//
//  String+Extension.swift
//  lib_basic
//
//  Created by 陶博 on 2021/6/26.
//  Copyright © 2021 lubansoft. All rights reserved.
//

import Foundation
import UIKit

public enum ValidateType: String {
    case passwordType = "^.{6,16}$"
}


// MARK: 字符串转字典
public extension String {
    
    /// 转换文件大小为KB  MB  GB
    /// - Returns: 大小
    func convertMemorySize() -> String {
        let formatter:ByteCountFormatter = ByteCountFormatter()
        formatter.countStyle = .binary
        return formatter.string(fromByteCount: Int64(self) ?? 0)
    }
    
    func toArray() -> Array<Any> {
        let jsonData: Data = self.data(using: .utf8)!
        let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
        return array as! Array
    }
    
    
    /// 获取APP版本号
    /// - Returns: string
    static func getAppVersionString() -> String {
        let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        return appVersion
    }
    
    /// 获取字符串的高度
    /// - Parameters:
    ///   - width: 控件的宽度
    ///   - font: 控件的font
    /// - Returns: 控件的高度
    func getStringHeight(width: CGFloat , font: UIFont) -> CGFloat {
        let textString: NSString = self as NSString
        let size =  CGSize(width: width, height: CGFloat(MAXFLOAT))
        let dic: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font]
        let H = textString.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: dic, context: nil).size.height
        return ceil(H)
    }
    
    /// 获取字符串的宽度
    /// - Parameters:
    ///   - height: 控件的宽度
    ///   - font: 控件的font
    /// - Returns: 控件的高度
    func getStringWidth(height: CGFloat , font: UIFont) -> CGFloat {
        let textString: NSString = self as NSString
        let size =  CGSize(width: CGFloat(MAXFLOAT), height: height)
        let dic: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font]
        let W = textString.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: dic, context: nil).size.width
        return ceil(W)
    }
    
    
    /// string转换为富文本
    /// - Parameters:
    ///   - highLight: 需要高亮的string
    ///   - font: 高亮的font
    ///   - color: 默认字符串的颜色
    ///   - highLightColor: 高亮的颜色
    /// - Returns: 富文本
    func highLightText(highLight: String, font: UIFont, color: UIColor, highLightColor: UIColor) -> NSMutableAttributedString {
        //定义富文本即有格式的字符串
        let attributedStrM : NSMutableAttributedString = NSMutableAttributedString()
        let strings = self.components(separatedBy: highLight)
        
        for i in 0..<strings.count {
            let item = strings[i]
            let dict = [NSAttributedString.Key.font: font,
                        NSAttributedString.Key.foregroundColor: color]
            
            let content = NSAttributedString(string: item, attributes: dict)
            attributedStrM.append(content)
            
            if i != strings.count - 1 {
                let dict1 = [NSAttributedString.Key.font: font,
                             NSAttributedString.Key.foregroundColor: highLightColor]
                
                let content2 = NSAttributedString(string: highLight,
                                                  attributes: dict1)
                attributedStrM.append(content2)
            }
            
        }
        return attributedStrM
    }
    
    func callPhone() {
        let phone = "telprompt://" + self
        if UIApplication.shared.canOpenURL(URL(string: phone)!) {
            UIApplication.shared.open(URL(string: phone)!, options: [:], completionHandler: nil)
        }
    }
    
    func isImageSuffix() -> Bool {
        let arr = self.components(separatedBy: ".")
        if arr.count > 1 {
            return ["jpeg","jpg","png","tif","tiff","gif","jpe","bmp","ico","heic","heif"].contains { obj in
                obj == arr.last!.lowercased()
            }
        }
        return false
    }
    
    /// 判断是否是视频格式
    /// - Returns: true or false
    func isVideoSuffix() -> Bool {
        let videoArr = ["mp4","mov","mkv","mpg","mpeg","avi","wmv","flv","swf","rm","rmvb","3gp"]
        let arr = self.components(separatedBy: ".")
        if arr.count > 1 {
            return videoArr.contains { obj in
                obj == arr.last!.lowercased()
            }
        }
        return false
    }
    
    var isEmptyOrBlank: Bool {
        isEmpty || isBlank
    }
    
    var isBlank: Bool {
        allSatisfy({$0.isWhitespace})
    }
    
    // 是否包含表情
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case
            0x00A0...0x00AF,
            0x2030...0x204F,
            0x2120...0x213F,
            0x2190...0x21AF,
            0x2310...0x329F,
            0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }
 
    /**
     * 字母、数字、中文正则判断（不包括空格）
     *注意: 因为考虑到输入习惯,许多人习惯使用九宫格,这里在正常选择全键盘输入错误的时候,进行九宫格判断,九宫格对应的是下面➋➌➍➎➏➐➑➒的字符
     */
    static func isInputRuleNotBlank(str:String) -> Bool {
        let pattern = "^[a-zA-Z\\u4E00-\\u9FA5\\d]*$"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch = pred.evaluate(with: str)
        if !isMatch {
            let other = "➋➌➍➎➏➐➑➒"
            let len = str.count
            for i in 0..<len {
                let tmpStr = str as NSString
                let tmpOther = other as NSString
                let c = tmpStr.character(at: i)
                
                if !((isalpha(Int32(c))) > 0 || (isalnum(Int32(c))) > 0 || ((Int(c) == "_".hashValue)) || (Int(c) == "-".hashValue) || ((c >= 0x4e00 && c <= 0x9fa6)) || (tmpOther.range(of: str).location != NSNotFound)) {
                    return false
                }
                return true
            }
        }
        return isMatch
    }
    
    
}
