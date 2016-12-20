//
//  MXAmuseViewController.swift
//  MXDouYuZhiBo
//
//  Created by 刘智援 on 2016/10/28.
//  Copyright © 2016年 lyoniOS. All rights reserved.
//

import UIKit

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

private let kItemW       : CGFloat = (kDeviceWidth - 3 * kItemMargin) / 2
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kPrettyItemH : CGFloat = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50
private let kTopViewH    : CGFloat = 200

class MXAmuseViewController: UIViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var amuseViewModel : MXAmuseViewModel = MXAmuseViewModel()
    
    fileprivate lazy var amuseTopView : MXAmuseTopView = {[weak self] in
        let amuseTopViewFrame = CGRect(origin: CGPoint(x: 0, y: -kTopViewH), size: CGSize(width: kDeviceWidth, height: kTopViewH))
        let amuseTopView = MXAmuseTopView.nibView()
        amuseTopView.frame = amuseTopViewFrame
        return amuseTopView
        }()
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kDeviceWidth, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        
        collectionView.dataSource   = self
        collectionView.delegate     = self
        collectionView.contentInset = UIEdgeInsets(top: kTopViewH, left: 0, bottom: kTabbarHeight + kNavigationBarHeight + kStatusBarHeight + 40, right: 0)
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
        
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        requestDatas()
    }
}

// MARK:- UI Frame
extension MXAmuseViewController {
    fileprivate func setupUI(){
        view.addSubview(collectionView)
        collectionView.addSubview(amuseTopView)
    }
}

// MARK:- Data Request
extension MXAmuseViewController {
    fileprivate func requestDatas(){
        amuseViewModel.requestAmuseData {
            self.collectionView.reloadData()
            
            // 2.2.调整数据
            var tempGroups = self.amuseViewModel.anchorGroups
            tempGroups.removeFirst()
            self.amuseTopView.anchorGroups = tempGroups
        }
    }
}

extension MXAmuseViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.amuseViewModel.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let anchorModel = self.amuseViewModel.anchorGroups[section]
        return anchorModel.anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)as! CollectionNormalCell
        // 2.设置数据
        cell.anchor = amuseViewModel.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionElementKindSectionHeader , withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 2.给HeaderView设置数据
        headView.group = amuseViewModel.anchorGroups[indexPath.section]
        return headView
    }
}

extension MXAmuseViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
