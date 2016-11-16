//
//  MXAnchorGroup.swift
//  MXDouYuZhiBo
//
//  Created by 刘智援 on 2016/10/29.
//  Copyright © 2016年 lyoniOS. All rights reserved.
//

import UIKit

class MXAnchorGroup: NSObject {
    // MARK:- 定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    /// 组显示的图标
    var icon_name : String = "home_header_normal"
    /// 定义主播的模型对象数组
    lazy var anchors : [MXAnchorModel] = [MXAnchorModel]()
    
    // MARK:- 自定义构造函数
    override init() {
        
    }
    
    /// 该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(MXAnchorModel(dict: dict))
            }
        }
    }
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    

}
