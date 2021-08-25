//
//  ViewController.swift
//  SwiftyFitsize_Scene
//
//  Created by LinXunFeng on 2021/8/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SwiftyFitsize
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        print("view.frame.width~:\(view.frame.width) => \(view.frame.width~)")
        print("view.frame.height∣-:\(view.frame.height) => \((view.frame.height)∣-)")
        print(self.view.frame~)
        
        self.view.backgroundColor = .white
        
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
        
        //  ∣ 和 ∥ 的区别，就是 ~ 和 ≈ 的区别一样
        //  ∣ 在ipad上会乘上一个系数，使在ipad上尺寸不会显得太大，请自行判断是否需要
        //  ∥ 则不会
        
        // 适配安全区域内的高度，请使用 ∣= or ∥=
        view1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(topMargin)
            make.height.equalTo(refHeight∥= * 0.5)
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
        }
        view6.snp.makeConstraints { make in
            make.top.equalTo(view5.snp.bottom)
            make.width.height.equalTo(view5)
            make.left.equalTo(view5).offset(-2)
        }
    }
}

