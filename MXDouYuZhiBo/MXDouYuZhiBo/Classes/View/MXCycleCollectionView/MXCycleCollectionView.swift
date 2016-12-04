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
   
    // MARK:- 定义属性
    var cycleTimer : Timer?
    var cycleModels : [MXCycleModel]?{
        didSet{
            collectionView.reloadData()
            
            pageControl.numberOfPages = (cycleModels?.count)!
            
            // 添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection          = .horizontal
        flowLayout.minimumLineSpacing       = 0
        flowLayout.minimumInteritemSpacing  = 0
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate                         = self as UICollectionViewDelegate?
        collectionView.dataSource                       = self as UICollectionViewDataSource?
        collectionView.isPagingEnabled                  = true
        collectionView.showsHorizontalScrollIndicator   = false
        collectionView.register(UINib.init(nibName: "MXCycleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kCycleCollectionCell)
        return collectionView
    }()
    
    fileprivate lazy var pageControl : UIPageControl = {[weak self] in
        let pageControl = UIPageControl(frame: CGRect.zero)
        return pageControl
        }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
        pageControl.frame = CGRect.init(x: bounds.width * 0.5, y: bounds.height - kPageControlHeight, width: bounds.width * 0.5, height: kPageControlHeight)
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
}

// MARK:- UICollectionViewDataSource
extension MXCycleCollectionView : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (cycleModels?.count ?? 0) * 10000//kMaxSectionNumber
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cycleModels?.count != 0 && cycleModels?.count != nil {
            return cycleModels!.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCollectionCell, for: indexPath) as! MXCycleCollectionViewCell
        cell.cycleModel = (cycleModels?[indexPath.item])!
        return cell
    }
}

// MARK:- UICollectionViewDelegate
extension MXCycleCollectionView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //暂停定时器
        removeCycleTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //开启定时器
        addCycleTimer()
    }
}

// MARK:- 对定时器的操作方法
extension MXCycleCollectionView {
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    
    fileprivate func removeCycleTimer() {
        cycleTimer?.invalidate() // 从运行循环中移除
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        // 1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width

        // 2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
