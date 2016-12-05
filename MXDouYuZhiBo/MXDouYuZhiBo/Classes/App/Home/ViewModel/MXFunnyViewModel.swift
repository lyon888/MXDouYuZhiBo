//
//  MXFunnyViewModel.swift
//  MXDouYuZhiBo
//
//  Created by 广东众网合一网络科技有限公司 on 16/12/5.
//  Copyright © 2016年 lyoniOS. All rights reserved.
//

import UIKit

class MXFunnyViewModel: NSObject {
    // MARK: - Lazy
    lazy var anchorModels :[MXAnchorModel] = [MXAnchorModel]()
    
}

extension MXFunnyViewModel{
    func requestFunnyData(finishedCallBack : @escaping() -> ()) {
        
        let parameters : [String : AnyObject] = ["limit" : 0 as AnyObject, "offset" : 0 as AnyObject]
        
        MXNetWorkTool.requestData(type: .get, urlString:"http://capi.douyucdn.cn/api/v1/getColumnRoom/3",parameters: parameters) { (response) in
            MXPrint(message: response)
            
            // 1.获取数据
            guard let resultDict = response as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 2.字典转模型
            for dict in dataArray {
                self.anchorModels.append(MXAnchorModel(dict: dict))
            }
            // 3.回调数据
            finishedCallBack()
        }
    }
}


