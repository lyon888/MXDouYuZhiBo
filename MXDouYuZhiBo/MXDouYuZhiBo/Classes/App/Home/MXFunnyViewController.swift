//
//  MXFunnyViewController.swift
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

class MXFunnyViewController: UIViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var funnyViewModel : MXFunnyViewModel = MXFunnyViewModel()
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kDeviceWidth, height: kItemMargin)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        
        collectionView.dataSource   = self
        collectionView.delegate     = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kTabbarHeight + kNavigationBarHeight + kStatusBarHeight + 40, right: 0)
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        return collectionView
        
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        requestDatas()
    }
}

// MARK:- UI Frame
extension MXFunnyViewController {
    fileprivate func setupUI(){
        view.addSubview(collectionView)
    }
}

// MARK:- Data Request
extension MXFunnyViewController {
    fileprivate func requestDatas(){
        funnyViewModel.requestFunnyData {
            self.collectionView.reloadData()
        }
    }
}

extension MXFunnyViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return funnyViewModel.anchorModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)as! CollectionNormalCell
            // 2.设置数据
            cell.anchor = funnyViewModel.anchorModels[indexPath.item]
            return cell
    }
}

extension MXFunnyViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
