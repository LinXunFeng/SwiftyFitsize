//
//  PortraitViewController.swift
//  SwiftyFitsize_Swift
//
//  Created by LinXunFeng on 2020/12/5.
//  Copyright © 2020 LinXunFeng. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyFitsize

class PortraitViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let popBtn = UIButton()
        popBtn.setTitle("POP", for: .normal)
        popBtn.backgroundColor = .black
        popBtn.addTarget(self, action: #selector(popBtnClick), for: .touchUpInside)
        self.view.addSubview(popBtn)
        popBtn.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        // 设计稿上的大小
        let refHeight: CGFloat = 667
        
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
        
        let topMargin: CGFloat = SwiftyFitsize.Config.Device.getSafeAreaTopMargin()
        let bottomMargin: CGFloat = SwiftyFitsize.Config.Device.getSafeAreaBottomMargin()
        print("bottomMargin -- \(bottomMargin)")
        
        //  ∣ 和 ∥ 的区别，就是 ~ 和 ≈ 的区别一样
        //  ∣ 在ipad上会乘上一个系数，使在ipad上尺寸不会显得太大，请自行判断是否需要
        //  ∥ 则不会
        
        // 适配安全区域内的高度，请使用 ∣= or ∥=
        view1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(topMargin)
            make.height.equalTo(refHeight∥= * 0.5)
//            make.height.equalTo(SwiftyFitsize.fit(size: refHeight, fitType: .flexibleSafeAreaCenterHeight, referenceHeight: 667) * 0.5)
//            make.height.equalTo(SwiftyFitsize.fit(size: refHeight, fitType: .forceSafeAreaCenterHeight, referenceHeight: 667) * 0.5)
            make.width.equalTo(50)
            make.left.equalTo(5)
        }
        view2.snp.makeConstraints { make in
            make.width.height.equalTo(view1)
            make.left.equalTo(view1).offset(2)
            make.top.equalTo(view1.snp.bottom)
        }
        
        // 适配全屏高度，请使用 ∣ or ∥
        view3.snp.makeConstraints { make in
            make.left.equalTo(view1.snp.right).offset(8)
            make.top.equalToSuperview()
            make.width.equalTo(view1)
            make.height.equalTo(refHeight∥ * 0.5)
//            make.height.equalTo(SwiftyFitsize.fit(size: refHeight, fitType: .flexibleHeight, referenceHeight: 667) * 0.5)
//            make.height.equalTo(SwiftyFitsize.fit(size: refHeight, fitType: .forceHeight, referenceHeight: 667) * 0.5)
//            make.height.equalTo(SwiftyFitsize.fit(size: refHeight, fitType: .flexibleHeight, referenceHeight: 667) * 0.5)
        }
        view4.snp.makeConstraints { make in
            make.top.equalTo(view3.snp.bottom)
            make.width.height.equalTo(view3)
            make.left.equalTo(view3).offset(2)
        }
        
        // 适配安全区域内的高度，请使用 ∣- or ∥-
        view5.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(topMargin)
            make.right.equalToSuperview().offset(-5)
            make.width.equalTo(view1)
            make.height.equalTo(refHeight∥- * 0.5)
//            make.height.equalTo(SwiftyFitsize.fit(size: refHeight, fitType: .flexibleSafeAreaWithoutTopHeight, referenceHeight: 667) * 0.5)
//            make.height.equalTo(SwiftyFitsize.fit(size: refHeight, fitType: .forceSafeAreaWithoutTopHeight, referenceHeight: 667) * 0.5)
        }
        view6.snp.makeConstraints { make in
            make.top.equalTo(view5.snp.bottom)
            make.width.height.equalTo(view5)
            make.left.equalTo(view5).offset(-2)
        }
    }
    
    @objc func popBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
}
