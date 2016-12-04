//
//  MXGameViewModel.swift
//  MXDouYuZhiBo
//
//  Created by 刘智援 on 2016/12/4.
//  Copyright © 2016年 lyoniOS. All rights reserved.
//

import UIKit

class MXGameViewModel: NSObject {
    lazy var games : [MXAnchorGroup] = [MXAnchorGroup]()
}

// MARK:- 发送网络请求
extension MXGameViewModel {
    // 请求推荐数据
    func requestData(_ finishCallback : @escaping () -> ()) {
        // 1.定义参数
        let parameters = ["shortName" : "game"]
        
        MXNetWorkTool.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: parameters as [String : AnyObject]) { (result) in
            
            // 1.获取到数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2.字典转模型
            for dict in dataArray {
                self.games.append(MXAnchorGroup(dict: dict))
            }
            
            // 3.完成回调
            finishCallback()
        }
    }
}
