//
//  MXHomeViewController.swift
//  MXDouYuZhiBo
//
//  Created by 刘智援 on 2016/10/27.
//  Copyright © 2016年 lyoniOS. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40;

class MXHomeViewController: UIViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var pageTitleView : MXPageTitleView = {[weak self] in
        let titleFrame = CGRect(origin: CGPoint(x: 0, y: kStatusBarHeight + kNavigationBarHeight), size: CGSize(width: kScreenWidth, height: kTitleViewH))
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = MXPageTitleView(frame: titleFrame, titles: titles)
        titleView.backgroundColor = UIColor.red
        titleView.delegate = self
        return titleView
        }()
    
    fileprivate lazy var pageContentView : MXPageContentView = {[weak self] in
        // 1.确定内容的frame
        let contentH = kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTitleViewH - kTabbarHeight
        let contentFrame = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight + kTitleViewH, width: kScreenWidth, height: contentH)
        
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(MXRecommendViewController())
        childVcs.append(MXGameViewController())
        childVcs.append(MXAmuseViewController())
        childVcs.append(MXFunnyViewController())
        
        let contentView = MXPageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        contentView.backgroundColor = UIColor.blue
        return contentView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setupUI()
    }
}

// MARK:- 遵守PageTitleViewDelegate协议
extension MXHomeViewController : MXPageTitleViewDelegate{
    func pageTitleView(_ titleView: MXPageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }
}

// MARK:- 遵守PageContentViewDelegate协议
extension MXHomeViewController : PageContentViewDelegate {
    func pageContentView(_ contentView: MXPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK:- Event Response
extension MXHomeViewController{
    @objc fileprivate func leftItemClick(){
        print("点击了logo")
    }
    @objc fileprivate func qrCodeItemClick() {
        print("点击了二维码")
    }
    @objc fileprivate func searchItemClick() {
        print("点击了搜索")
    }
    @objc fileprivate func historyItemClick() {
        print("点击了历史")
    }
}
// MARK:- UI Frame
extension MXHomeViewController {
    
    fileprivate func setupUI(){
        automaticallyAdjustsScrollViewInsets = false
        setupNavigationBar()
        setupContentView()
    }
    
    fileprivate func setupNavigationBar(){
        setupNavigationLeftBar()
        setupNavigationRightBar()
    }
    
    fileprivate func setupContentView(){
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
    
    fileprivate func setupNavigationLeftBar() {
        //        navigationItem.leftBarButtonItem = UIBarButtonItem.createBarButtonItem(imageName: "logo", target: self, action: #selector(self.leftItemClick))
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", target: self, action: #selector(self.leftItemClick))
    }
    fileprivate func setupNavigationRightBar() {
        //        let size = CGSize(width: 40, height: 44)
        //        let historyItem = UIBarButtonItem.createBarButtonItem(imageName: "image_my_history", highImageName: "image_my_history_click", size: size, target: self, action: #selector(self.historyItemClick))
        //        let searchItem = UIBarButtonItem.createBarButtonItem(imageName: "btn_search", highImageName: "btn_search_click", size: size, target: self, action: #selector(self.searchItemClick))
        //        let qrCodeItem = UIBarButtonItem.createBarButtonItem(imageName: "image_scan", highImageName: "image_scan_click", size: size, target: self, action: #selector(self.qrCodeItemClick))
        //        navigationItem.rightBarButtonItems = [historyItem, searchItem , qrCodeItem]
        let size = CGSize(width: 40, height: 44)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "image_my_history_click", size: size, target: self, action: #selector(self.historyItemClick))
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_click", size: size, target: self, action: #selector(self.searchItemClick))
        let qrCodeItem = UIBarButtonItem(imageName: "image_scan", highImageName: "image_scan_click", size: size, target: self, action: #selector(self.qrCodeItemClick))
        navigationItem.rightBarButtonItems = [historyItem, searchItem , qrCodeItem]
    }
}


// MARK:- Private Method
//系统类扩充方法
extension UIBarButtonItem {
    class func createBarButtonItem(_ imageName : String, highImageName : String = "", size : CGSize = CGSize(width : 0 , height : 0), target : AnyObject? = nil, action : Selector! = nil) -> UIBarButtonItem {
        // 1.创建UIButton
        let btn = UIButton(type: .custom)
        // 2.给UIButton设置属性
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        // 3.设置尺寸
        if size == CGSize(width : 0 , height : 0) {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint(x : 0 ,y : 0), size: size)
        }
        // 4.监听点击
        btn.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }
}
//扩充遍历构造函数（推荐做法）
//
//遍历构造函数特点
//构造函数前以convenience开头
//必须明确调用设计构造函数：例如self.init()
extension UIBarButtonItem {
    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSize(width : 0 , height : 0), target : AnyObject? = nil, action : Selector? = nil) {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        if size == CGSize(width : 0 , height : 0) {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint(x : 0 ,y : 0), size: size)
        }
        btn.addTarget(target, action: action!, for: .touchUpInside)
        self.init(customView: btn)
    }
}

 
