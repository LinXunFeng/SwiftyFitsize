//
//  LandscapeViewController.swift
//  SwiftyFitsize_Swift
//
//  Created by LinXunFeng on 2020/12/3.
//  Copyright © 2020 LinXunFeng. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyFitsize

class LandscapeViewController: UIViewController {
    
    fileprivate let fitLabel1 : UILabel = {
        let v = UILabel()
        let fontSize: CGFloat = 45
        v.font = UIFont(name: "PingFangSC-Regular", size: fontSize)!∥-
        v.text = "https://github.com/LinXunFeng"
        return v
    }()
    
    fileprivate let fitLabel2 : UILabel = {
        let v = UILabel()
        let fontSize: CGFloat = 45
        v.font = UIFont(name: "PingFangSC-Regular", size: fontSize)!∥=
        v.text = "https://github.com/LinXunFeng"
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // 设计稿上的大小
        let refWidth: CGFloat = 667
        
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        let view4 = UIView()
        let view5 = UIView()
        let view6 = UIView()
        view1.backgroundColor = .red
        view2.backgroundColor = .blue
        view3.backgroundColor = .orange
        view4.backgroundColor = .green
        view5.backgroundColor = .purple
        view6.backgroundColor = .systemPink
        self.view.addSubview(view1)
        self.view.addSubview(view2)
        self.view.addSubview(view3)
        self.view.addSubview(view4)
        self.view.addSubview(view5)
        self.view.addSubview(view6)
        self.view.addSubview(fitLabel1)
        self.view.addSubview(fitLabel2)
        
        var leftMargin: CGFloat = 0
        if #available(iOS 11.0, *) {
            // print(UIApplication.shared.keyWindow?.safeAreaInsets)
            leftMargin = UIApplication.shared.keyWindow?.safeAreaInsets.left ?? 0
        }
        var leftBangMargin: CGFloat = 0
        if UIApplication.shared.statusBarOrientation == .landscapeRight {
            leftBangMargin = leftMargin
        }
        
        
        //  ∣ 和 ∥ 的区别，就是 ~ 和 ≈ 的区别一样
        //  ∣ 在ipad上会乘上一个系数，使在ipad上尺寸不会显得太大，请自行判断是否需要
        //  ∥ 则不会
        
        // 适配安全区域内的高度，请使用 ∣= or ∥=
        let view1TopMargin = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ? 100 : 50
        view1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view1TopMargin)
            make.height.equalTo(20)
            make.left.equalTo(0).offset(leftMargin)
            make.width.equalTo(refWidth∥= * 0.5)
//            make.width.equalTo(SwiftyFitsize.fit(size: refWidth, fitType: .flexibleSafeAreaCenterHeight, referenceHeight: 667) * 0.5)
        }
        view2.snp.makeConstraints { make in
            make.width.height.equalTo(view1)
            make.left.equalTo(view1.snp.right)
            make.top.equalTo(view1).offset(2)
        }
        
        // 适配全屏高度，请使用 ∣ or ∥
        view3.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(view1.snp.bottom).offset(8)
            make.height.equalTo(view1)
            make.width.equalTo(refWidth∥ * 0.5)
//            make.width.equalTo(SwiftyFitsize.fit(size: refWidth, fitType: .flexibleHeight, referenceHeight: 667) * 0.5)
        }
        view4.snp.makeConstraints { make in
            make.top.equalTo(view3).offset(2)
            make.width.height.equalTo(view3)
            make.left.equalTo(view3.snp.right)
        }
        
        // 适配安全区域内的高度，请使用 ∣- or ∥-
        view5.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(leftBangMargin)
            make.height.equalTo(view1)
            make.width.equalTo(refWidth∥- * 0.5)
//            make.width.equalTo(SwiftyFitsize.fit(size: refWidth, fitType: .flexibleSafeAreaWithoutTopHeight, referenceHeight: 667) * 0.5)
            make.bottom.equalTo(view6.snp.bottom).offset(-2)
        }
        view6.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.width.height.equalTo(view5)
            make.left.equalTo(view5.snp.right)
        }
        
        fitLabel1.snp.makeConstraints { make in
            make.top.equalTo(view3.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(leftBangMargin)
        }
        fitLabel2.snp.makeConstraints { make in
            make.top.equalTo(fitLabel1.snp.bottom).offset(8)
            make.left.equalTo(view1)
        }
    }
}
