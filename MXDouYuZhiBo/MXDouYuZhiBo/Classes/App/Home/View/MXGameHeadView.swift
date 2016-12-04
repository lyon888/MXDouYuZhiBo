//
//  MXGameHeadView.swift
//  MXDouYuZhiBo
//
//  Created by 刘智援 on 2016/12/4.
//  Copyright © 2016年 lyoniOS. All rights reserved.
//

import UIKit

class MXGameHeadView: UICollectionReusableView {

    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
    }
    
    // MARK: - 属性
    var lineViewBgColor : UIColor? {
        didSet{
            lineView?.backgroundColor = lineViewBgColor!
        }
    }
    var sectionTitle    : String?{
        didSet{
            sectionTitleLabel?.text = sectionTitle
        }
    }
}

// MARK:- 从Xib中快速创建的类方法
extension MXGameHeadView {
    class func nibView() -> MXGameHeadView {
        return Bundle.main.loadNibNamed("MXGameHeadView", owner: nil, options: nil)?.first as! MXGameHeadView
    }
}
