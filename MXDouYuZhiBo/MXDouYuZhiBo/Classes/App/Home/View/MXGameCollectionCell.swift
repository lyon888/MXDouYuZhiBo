//
//  MXGameCollectionCell.swift
//  MXDouYuZhiBo
//
//  Created by 广东众网合一网络科技有限公司 on 16/12/3.
//  Copyright © 2016年 lyoniOS. All rights reserved.
//

import UIKit

class MXGameCollectionCell: UICollectionViewCell {

    var anchorGroup : MXAnchorGroup?{
        didSet{
            titleLabel.text = anchorGroup?.tag_name
            if let iconURL = URL(string: anchorGroup?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconURL)
            }else{
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
}
