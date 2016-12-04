//
//  MXConstant.swift
//  MXDouYuZhiBo
//
//  Created by 刘智援 on 2016/10/27.
//  Copyright © 2016年 lyoniOS. All rights reserved.
//

import UIKit

///-----------------------------------------------------------------------------
/// @name 常量 Const
///-----------------------------------------------------------------------------
let kDeviceWidth    = UIScreen.main.bounds.width
let kDeviceHeight   = UIScreen.main.bounds.height

let kStatusBarHeight        : CGFloat = 20
let kNavigationBarHeight    : CGFloat = 44
let kTabbarHeight           : CGFloat = 49
let kGlobalMargin           : CGFloat = 10

///-----------------------------------------------------------------------------
/// @name 暴力打印 Log
///-----------------------------------------------------------------------------
func MXPrint<T>(message: T,
                file:    String = #file,
                method:  String = #function,
                line:    Int    = #line)
{
    #if DEBUG
        print("==================begin======================\n类名:\((file as NSString).lastPathComponent)[第\(line)行],\n 方法:\(method):\n输出信息: \(message)\n===================end======================")
    #endif
}
