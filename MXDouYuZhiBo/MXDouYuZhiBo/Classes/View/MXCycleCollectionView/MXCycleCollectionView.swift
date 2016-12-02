//
//  MXCycleCollectionView.swift
//  MXDouYuZhiBo
//
//  Created by 广东众网合一网络科技有限公司 on 16/12/2.
//  Copyright © 2016年 lyoniOS. All rights reserved.
//

import UIKit

private let kMaxSectionNumber : Int         = 20
private let kPageControlHeight : CGFloat    = 35
private let kCycleCollectionCell : String   = "kCycleCollectionCell"

class MXCycleCollectionView: UIView {
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection          = .horizontal
        flowLayout.minimumLineSpacing       = 0
        flowLayout.minimumInteritemSpacing  = 0
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate     = self as UICollectionViewDelegate?
        collectionView.dataSource   = self as UICollectionViewDataSource?
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    fileprivate lazy var pageControl : UIPageControl = {[weak self] in
        let pageControl = UIPageControl(frame: CGRect.zero)
        pageControl.backgroundColor = UIColor.brown
        return pageControl
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupCollectionView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 添加内容
extension MXCycleCollectionView{
    fileprivate func setupUI() {
        addSubview(collectionView)
        addSubview(pageControl)
    }
    
    fileprivate func setupCollectionView() {
        collectionView.register(UINib.init(nibName: "MXCycleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kCycleCollectionCell)
    }
}
// MARK:- 布局
extension MXCycleCollectionView{
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
        pageControl.frame = CGRect.init(x: bounds.width * 0.5, y: bounds.height - kPageControlHeight, width: bounds.width * 0.5, height: kPageControlHeight)
    }
}
// MARK:- UICollectionViewDataSource
extension MXCycleCollectionView : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return kMaxSectionNumber
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCollectionCell, for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        return cell
    }
}

// MARK:- UICollectionViewDelegate
extension MXCycleCollectionView : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
