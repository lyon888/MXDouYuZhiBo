//
//  MXRecommendViewController.swift
//  MXDouYuZhiBo
//
//  Created by 刘智援 on 2016/10/28.
//  Copyright © 2016年 lyoniOS. All rights reserved.
//

import UIKit

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kPrettyCellID = "kPrettyCellID"

private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kDeviceWidth - 3 * kItemMargin) / 2
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kPrettyItemH : CGFloat = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

class MXRecommendViewController: UIViewController {
    
    // MARK:- 属性
    //    fileprivate var headView : UICollectionReusableView = UICollectionReusableView()
    
    // MARK:- 懒加载属性
    fileprivate lazy var recommendVM : MXRecommendViewModel = MXRecommendViewModel()
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
        collectionView.dataSource = self
        collectionView.delegate = self
        //        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kTabbarHeight + kNavigationBarHeight + kStatusBarHeight + 40, right: 0)
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
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
extension MXRecommendViewController {
    fileprivate func setupUI(){
        view.addSubview(collectionView)
    }
}

// MARK:- Data Request
extension MXRecommendViewController {
    fileprivate func requestDatas(){
        recommendVM.requestData {
            print(self.recommendVM.anchorGroups)
            self.collectionView.reloadData()
        }
        recommendVM.requestCycleData {
            
        }
    }
}

// MARK:- UICollectionViewDelegate UICollectionViewDataSource
extension MXRecommendViewController : UICollectionViewDelegate{
    
}

extension MXRecommendViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.recommendVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let anchorModel = self.recommendVM.anchorGroups[section]
        return anchorModel.anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            // 1.取出PrettyCell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            // 2.设置数据
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return prettyCell
        }else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)as! CollectionNormalCell
            // 2.设置数据
            cell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionElementKindSectionHeader , withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 2.给HeaderView设置数据
        headView.group = recommendVM.anchorGroups[indexPath.section]
        return headView
    }
}

extension MXRecommendViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}



