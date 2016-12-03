//
//  MXGameCollectionView.swift
//  MXDouYuZhiBo
//
//  Created by 广东众网合一网络科技有限公司 on 16/12/3.
//  Copyright © 2016年 lyoniOS. All rights reserved.
//

import UIKit

let kGameCollectionCell : String = "kGameCollectionCell"

class MXGameCollectionView: UIView {
    
    // MARK: - Lazy
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection          = .horizontal
        flowLayout.minimumLineSpacing       = 0
        flowLayout.minimumInteritemSpacing  = 0
        flowLayout.itemSize                 = CGSize.init(width: 80, height: 90)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate                         = self as UICollectionViewDelegate?
        collectionView.dataSource                       = self as UICollectionViewDataSource?
        collectionView.isPagingEnabled                  = true
        collectionView.showsHorizontalScrollIndicator   = false
        collectionView.register(UINib.init(nibName: "MXGameCollectionCell", bundle: nil), forCellWithReuseIdentifier: kGameCollectionCell)
        return collectionView
        }()

    
    // MARK: - Life Cycle
    override init(frame:CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
extension MXGameCollectionView{
    fileprivate func setupUI(){
        addSubview(collectionView)
    }
}

// MARK: - UICollectionViewDataSource
extension MXGameCollectionView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCollectionCell, for: indexPath) 
        
        
        return cell
    }
    
}
// MARK: - UICollectionViewDelegate
extension MXGameCollectionView : UICollectionViewDelegate{

}

