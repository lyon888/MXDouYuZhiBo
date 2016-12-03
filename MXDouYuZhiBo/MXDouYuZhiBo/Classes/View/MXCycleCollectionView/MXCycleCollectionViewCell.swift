//
//  MXCycleCollectionViewCell.swift
//  MXDouYuZhiBo
//
//  Created by 广东众网合一网络科技有限公司 on 16/12/2.
//  Copyright © 2016年 lyoniOS. All rights reserved.
//

import UIKit

class MXCycleCollectionViewCell: UICollectionViewCell {

    // MARK: - 定义属性
    var cycleModel : MXCycleModel?{
        didSet{
            guard let iconURL = URL(string: cycleModel?.pic_url ?? "") else {
                return
            }
            bannerImageView.kf.setImage(with: iconURL)
            bannerTitleLabel.text = cycleModel?.title
        }
    }
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var bannerTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
}
