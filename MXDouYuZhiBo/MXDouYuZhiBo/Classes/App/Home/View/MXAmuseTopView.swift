//
//  MXAmuseTopView.swift
//  MXDouYuZhiBo
//
//  Created by 刘智援 on 2016/12/5.
//  Copyright © 2016年 lyoniOS. All rights reserved.
//

import UIKit

private let kCollectionViewCell = "kCollectionViewCell"
private let pageControlHeight : CGFloat  = 30.0

class MXAmuseTopView: UIView {
    @IBOutlet weak var collectionView   : UICollectionView!
    @IBOutlet weak var flowLayout       : UICollectionViewFlowLayout!
    @IBOutlet weak var pageControl      : UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        flowLayout.minimumLineSpacing       = 0
        flowLayout.minimumInteritemSpacing  = 0
        
        collectionView.dataSource       = self
        collectionView.isPagingEnabled  = true
        collectionView.register(UINib.init(nibName: "MXCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kCollectionViewCell)
        
        pageControl.backgroundColor = UIColor.blue
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        collectionView.frame = CGRect.init(x: 0, y: 0, width: kDeviceWidth, height: bounds.height - pageControlHeight)
        
        flowLayout.itemSize = CGSize.init(width: kDeviceWidth, height: collectionView.frame.height)
    }
}


extension MXAmuseTopView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCell, for: indexPath) as!MXCollectionViewCell
        return cell
    }
}

extension MXAmuseTopView {
    class func nibView() -> MXAmuseTopView {
        return Bundle.main.loadNibNamed("MXAmuseTopView", owner: nil, options: nil)?.first as! MXAmuseTopView
    }
}

