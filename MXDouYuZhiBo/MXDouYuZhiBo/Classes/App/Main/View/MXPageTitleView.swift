//
//  MXPageTitleView.swift
//  MXDouYuZhiBo
//
//  Created by 刘智援 on 2016/10/27.
//  Copyright © 2016年 lyoniOS. All rights reserved.
//

import UIKit
// MARK:- 定义协议
protocol MXPageTitleViewDelegate : class {
    func pageTitleView(_ titleView : MXPageTitleView, selectedIndex index : Int)
}

// MARK:- 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

// MARK:-定义PageTitleView类
class MXPageTitleView: UIView {
    
    // MARK:-定义属性
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String]
    weak var delegate : MXPageTitleViewDelegate?
    
    // MARK:-懒加载属性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.backgroundColor = UIColor.white
        scrollView.bounces = false
        return scrollView
    }()
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        super.init(frame : frame)
        
        //设置UI界面
        setupUI()
        setupSubViewLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:- Event Response
extension MXPageTitleView {
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer) {
        
        // 0.获取当前Label
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        // 1.如果是重复点击同一个Title,那么直接返回
        if currentLabel.tag == currentIndex { return }

        // 2.获取之前的Label
        let oldLabel = titleLabels[currentIndex]

        // 3.切换文字的颜色
        currentLabel.textColor = UIColor.orange//(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor.black//(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)

        // 4.保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        // 5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
        
        // 6.通知代理
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}


// MARK:- 设置UI界面
extension MXPageTitleView{
    fileprivate func setupUI(){
        addSubview(scrollView)
        setupTitleLabels()
        // 3.设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
    }
    
    fileprivate func setupTitleLabels(){
        for (index , title) in titles.enumerated() {
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.black
            label.textAlignment = .center
            scrollView.addSubview(label);
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    fileprivate func setupBottomLineAndScrollLine() {
        // 1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        addSubview(bottomLine)
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        
        // 2.添加scrollLine
        
        // 2.2.设置scrollLine的属性
        scrollView.addSubview(scrollLine)
      
    }

}

// MARK:- 设置UI Frame
extension MXPageTitleView{
    fileprivate func setupSubViewLayout(){
        scrollView.frame = bounds
        
        // 0.确定label的一些frame的值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index , label) in titleLabels.enumerated() {
            // 3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
        }
       
        // 2.1.获取第一个Label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange//(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
    
}

// MARK:- 对外暴露的方法
extension MXPageTitleView {
    func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
//        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor.orange//(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor.red//(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4.记录最新的index
        currentIndex = targetIndex
    }
}
