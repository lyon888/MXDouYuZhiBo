//
//  MXCycleModel.swift
//  MXDouYuZhiBo
//
//  Created by 广东众网合一网络科技有限公司 on 16/12/2.
//  Copyright © 2016年 lyoniOS. All rights reserved.
//

import UIKit

class MXCycleModel: NSObject {
    /// 轮播图标题
    var title : String = ""
    
    var pic_url : String = ""
 
    var isVertical : Int = 0
    /// 房间名称
    var room_name : String = ""
    /// 主播昵称
    var nickname : String = ""
    /// 观看人数
    var online : Int = 0
    /// 所在城市
    var anchor_city : String = ""
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    
    }
}
    
 
