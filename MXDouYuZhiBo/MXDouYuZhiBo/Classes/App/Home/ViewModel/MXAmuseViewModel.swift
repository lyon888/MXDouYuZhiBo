//
//  MXAmuseViewModel.swift
//  MXDouYuZhiBo
//
//  Created by 广东众网合一网络科技有限公司 on 16/12/5.
//  Copyright © 2016年 lyoniOS. All rights reserved.
//

import UIKit

class MXAmuseViewModel: NSObject {
    // MARK: - Lazy
    lazy var anchorGroups :[MXAnchorGroup] = [MXAnchorGroup]()
    
}

extension MXAmuseViewModel{
    func requestAmuseData(finishedCallBack : @escaping() -> ()) {
        
        let parameters : [String : AnyObject] = [:]
        
        MXNetWorkTool.requestData(type: .get, urlString:"http://capi.douyucdn.cn/api/v1/getHotRoom/2",parameters: parameters) { (response) in
            MXPrint(message: response)
            
            // 1.获取数据
            guard let resultDict = response as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 2.字典转模型
            for dict in dataArray {
                self.anchorGroups.append(MXAnchorGroup(dict: dict))
            }
            // 3.回调数据
            finishedCallBack()
        }
    }
}

  
