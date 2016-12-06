//
//  MXAmuseTopView.swift
//  MXDouYuZhiBo
//
//  Created by 刘智援 on 2016/12/5.
//  Copyright © 2016年 lyoniOS. All rights reserved.
//

import UIKit

private let kCollectionViewCell = "kCollectionViewCell"

class MXAmuseTopView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.red
        collectionView.register(UINib.init(nibName: "MXCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kCollectionViewCell)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
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

