//
//  LBBaseResponse.swift
//  lib_common
//
//  Created by 陶博 on 2021/6/25.
//  Copyright © 2021 lubansoft. All rights reserved.
//

import Foundation
import HandyJSON

//MARK:-- 返回的基本数据
public class LBBaseResponse: HandyJSON {
    public var code: Int?
    public var message: String?
    public required init() {}
}

//MARK:-- 包含result的数据
public class LBResultResponse<T>: HandyJSON {
    public var code: ResponseCodeType?
    public var success: Bool?
    public var msg: String?
    public var result: T?
    public required init() {}
}

//MARK:-- 包含data的数据
public class LBDataResponse<T>: HandyJSON {
    public var code: ResponseCodeType?
    public var success: Bool?
    public var msg: String?
    public var data: T?
    public required init() {}
}



