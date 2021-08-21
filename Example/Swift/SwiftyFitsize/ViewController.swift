//
//  ViewController.swift
//  SwiftyFitsize
//
//  Created by LinXunFeng on 10/17/2018.
//  Copyright (c) 2018 LinXunFeng. All rights reserved.
//

import UIKit
import SwiftyFitsize
import LXFProtocolTool
import SnapKit

struct Metric {
    static let tableViewLeftRightMargin: CGFloat = 10
    static let tableViewTopMargin: CGFloat = 10
    static let tableViewHeight: CGFloat = Fit.$width(30) // 去掉左右边距后进行适配的值
    static let rowViewTopMargin: CGFloat = 5
    static let rowViewHeight: CGFloat = tableViewHeight - rowViewTopMargin * 2
    static let rowLeftViewWidth: CGFloat = Fit.$width(177.5)
    static let rowCenterViewWidth: CGFloat = Fit.$width(100.5)
    static let rowRightViewWidth: CGFloat = Fit.$width(77)
}

struct Fit {
//    @WrappedSwiftyFitsize(fitType: .flexibleWidth, reduceValue: Metric.tableViewLeftRightMargin)
    @WrappedSwiftyFitsize(reduceValue: Metric.tableViewLeftRightMargin) // fitType 默认值是 .flexibleWidth
    static var width: CGFloat = 375
    // 375是初始化值，没有特殊意义，只为调用 Fit.width 时可以取到值，如果用不到 Fit.width 的值可以不进行初始化
}

class ViewController: UIViewController {
    
    fileprivate let fitLabel : UILabel = {
        let v = UILabel()
        v.font = UIFont.boldSystemFont(ofSize: 25)~
        v.text = "https://github.com/LinXunFeng"
        return v
    }()
    
    fileprivate let redView : UIView = {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 移除指定大小后的适配
        self.testFitWidthForReduceSize()
        
        let portraitBtn = UIButton()
        portraitBtn.setTitle("竖屏后点我", for: .normal)
        portraitBtn.backgroundColor = .brown
        portraitBtn.addTarget(self, action: #selector(portraitBtnClick), for: .touchUpInside)
        
        let landscapeBtn = UIButton()
        landscapeBtn.setTitle("横屏后点我", for: .normal)
        landscapeBtn.backgroundColor = .brown
        landscapeBtn.addTarget(self, action: #selector(landscapeBtnClick), for: .touchUpInside)
        
        self.view.addSubview(fitLabel)
        self.view.addSubview(redView)
        self.view.addSubview(portraitBtn)
        self.view.addSubview(landscapeBtn)
        
        fitLabel.sizeToFit()
        let fitLabelX: CGFloat = 15
        let fitLabelY: CGFloat = 100
        var frame = fitLabel.frame
        frame.origin.x = fitLabelX~
        frame.origin.y = fitLabelY~
        fitLabel.frame = frame
        
        let redViewFrame = CGRect(
            x: fitLabelX,
            y: fitLabelY + 50,
            width: 100,
            height: 100)
        redView.frame = redViewFrame~
        
        let tableView = UIView()
        tableView.backgroundColor = .darkGray
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Metric.tableViewLeftRightMargin)
            make.right.equalToSuperview().offset(-Metric.tableViewLeftRightMargin)
            make.top.equalTo(self.redView.snp.bottom).offset(Metric.tableViewTopMargin)
            make.height.equalTo(Metric.tableViewHeight)
        }
        let rowLeftView = UIView()
        rowLeftView.backgroundColor = .red
        tableView.addSubview(rowLeftView)
        rowLeftView.snp.makeConstraints { make in
            make.width.equalTo(Metric.rowLeftViewWidth)
            make.height.equalTo(Metric.rowViewHeight)
            make.top.equalTo(Metric.rowViewTopMargin)
            make.left.equalToSuperview()
        }
        let rowCenterView = UIView()
        rowCenterView.backgroundColor = .green
        tableView.addSubview(rowCenterView)
        rowCenterView.snp.makeConstraints { make in
            make.width.equalTo(Metric.rowCenterViewWidth)
            make.height.top.equalTo(rowLeftView)
            make.left.equalTo(rowLeftView.snp.right)
        }
        let rowRightView = UIView()
        rowRightView.backgroundColor = .blue
        tableView.addSubview(rowRightView)
        rowRightView.snp.makeConstraints { make in
            make.width.equalTo(Metric.rowRightViewWidth)
            make.height.top.equalTo(rowLeftView)
            make.left.equalTo(rowCenterView.snp.right)
        }
        
        let fitsizeView = FitsizeView.loadFromNib()
        self.view.addSubview(fitsizeView)
        fitsizeView.frame = CGRect(x: 0, y: redViewFrame~.maxY + Metric.tableViewHeight, width: 328~, height: 298~)
        
        portraitBtn.snp.makeConstraints { make in
            make.left.equalTo(redView.snp.right).offset(5)
            make.height.equalTo(40~)
            make.width.equalTo(120)
            make.top.equalTo(redView)
        }
        landscapeBtn.snp.makeConstraints { make in
            make.left.width.height.equalTo(portraitBtn)
            make.top.equalTo(portraitBtn.snp.bottom).offset(10)
        }
    }
    
    @objc func portraitBtnClick() {
        let vc = PortraitViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func landscapeBtnClick() {
        let vc = LandscapeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController {
    /// 移除指定大小后的适配
    func testFitWidthForReduceSize() {
        print("默认适配的宽度: \(Fit.width)")
        
        // 移除指定尺寸后的适配，调用方式：
        // 以下都是以适配 tableView 为例，移除 tableView 左右两侧固定的边距，以剩余的宽度来做适配
        
        // 方式一：先赋值再取值
        // 将 20 进行适配
        Fit.width = 20
        print("适配后的值 -- \(Fit.width)")
        
        // 方式二：使用 $ 将 width 当方法用，传入待适配的值
        // 将 30 进行适配
        let aVal = Fit.$width(30)
        print("适配后的值 aVal -- \(aVal)")
        
        // 方式三：调用 SwiftyFitsize.fit 方法
        let bVal = SwiftyFitsize.fit(
            size: 40,
            fitType: .flexibleWidth,
            reduceValue: Metric.tableViewLeftRightMargin * 2
        )
        print("适配后的值 bVal -- \(bVal)")
    }
}

