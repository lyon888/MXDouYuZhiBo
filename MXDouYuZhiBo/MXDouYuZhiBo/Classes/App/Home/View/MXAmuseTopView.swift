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
    
    var anchorGroups : [MXAnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        flowLayout.minimumLineSpacing       = 0
        flowLayout.minimumInteritemSpacing  = 0
        
        collectionView.delegate         = self
        collectionView.dataSource       = self
        collectionView.isPagingEnabled  = true
        collectionView.register(UINib.init(nibName: "MXCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kCollectionViewCell)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = CGRect.init(x: 0, y: 0, width: kDeviceWidth, height: bounds.height - pageControlHeight)
        
        flowLayout.itemSize  = CGSize.init(width: kDeviceWidth, height: collectionView.frame.height)
    }
}

extension MXAmuseTopView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if anchorGroups == nil { return 0 }
        let pageNum = (anchorGroups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCell, for: indexPath) as!MXCollectionViewCell
        // 2.给cell设置数据
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func setupCellDataWithCell(cell : MXCollectionViewCell, indexPath : IndexPath) {
        // 0页: 0 ~ 7
        // 1页: 8 ~ 15
        // 2也: 16 ~ 23
        // 1.取出起始位置&终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        // 2.判断越界问题
        if endIndex > anchorGroups!.count - 1 {
            endIndex = anchorGroups!.count - 1
        }
        // 3.取出数据,并且赋值给cell
        cell.anchorGroups = Array(anchorGroups![startIndex...endIndex])
    }
}

extension MXAmuseTopView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + (scrollView.bounds.width * 0.5)
        let currentPage = Int(offsetX / scrollView.bounds.width)
        pageControl.currentPage = currentPage
    }
}

extension MXAmuseTopView {
    class func nibView() -> MXAmuseTopView {
        return Bundle.main.loadNibNamed("MXAmuseTopView", owner: nil, options: nil)?.first as! MXAmuseTopView
    }
}
