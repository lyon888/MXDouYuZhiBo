//
//  MXGameViewController.swift
//  MXDouYuZhiBo
//
//  Created by 刘智援 on 2016/10/28.
//  Copyright © 2016年 lyoniOS. All rights reserved.
//

import UIKit

let kGameHeadView : String = "kGameHeadView"

private let kItemW       : CGFloat = kDeviceWidth / 3
private let kNormalItemH : CGFloat = kItemW + 30
private let kHeaderViewH : CGFloat = 35
private let kGameViewH   : CGFloat = 90

class MXGameViewController: UIViewController {

    // MARK: - 属性
    fileprivate lazy var gameViewModel  : MXGameViewModel       = MXGameViewModel()
    
    // MARK: - Lazy
    fileprivate lazy var gameHeadView : MXGameHeadView = {[weak self] in
        let gameHeadViewFrame = CGRect(origin: CGPoint(x: 0, y: -kGameViewH-kHeaderViewH-kItemMargin), size: CGSize(width: kDeviceWidth, height: kHeaderViewH))
        let gameHeadView = MXGameHeadView.nibView()
        gameHeadView.frame = gameHeadViewFrame
        gameHeadView.lineViewBgColor = UIColor.orange
        gameHeadView.sectionTitle    = "常用"
        return gameHeadView
        }()
    
    fileprivate lazy var gameCollectionView : MXGameCollectionView = {[weak self] in
        let gameCollectionViewFrame = CGRect(origin: CGPoint(x: 0, y: -kGameViewH-kItemMargin), size: CGSize(width: kDeviceWidth, height: kGameViewH))
        let gameCollectionView = MXGameCollectionView(frame: gameCollectionViewFrame)
        gameCollectionView.backgroundColor = UIColor.white
        return gameCollectionView
        }()
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing       = 0
        layout.minimumInteritemSpacing  = 0//kItemMargin
        layout.headerReferenceSize = CGSize(width: kDeviceWidth, height: kHeaderViewH)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = kGlobalBgColor
        collectionView.dataSource   = self
        collectionView.contentInset = UIEdgeInsets(top: kGameViewH+kHeaderViewH+kItemMargin, left: 0, bottom: kTabbarHeight + kNavigationBarHeight + kStatusBarHeight + 40, right: 0)
        
        collectionView.register(UINib(nibName: "MXGameCollectionCell", bundle: nil), forCellWithReuseIdentifier: kGameCollectionCell)
        collectionView.register(UINib(nibName: "MXGameHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kGameHeadView)
        return collectionView
        
        }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        setupRequestData()
    }
}
// MARK: - UI
extension MXGameViewController{
    func setupUI() {
        view.addSubview(collectionView)
        collectionView.addSubview(gameHeadView)
        collectionView.addSubview(gameCollectionView)
        
    }
    func setupRequestData(){
        gameViewModel.requestData{
            self.collectionView.reloadData()
            self.gameCollectionView.anchorGroups = Array(self.gameViewModel.games[0..<10])
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MXGameViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.games.count 
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCollectionCell, for: indexPath) as! MXGameCollectionCell
        cell.anchorGroup = gameViewModel.games[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let headView = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionElementKindSectionHeader , withReuseIdentifier: kGameHeadView, for: indexPath) as! MXGameHeadView
        headView.lineViewBgColor = UIColor.orange
        headView.sectionTitle    = "全部"
        return headView
    }
}


