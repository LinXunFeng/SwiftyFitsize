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
        
        let fitsizeView = FitsizeView.loadFromNib()
        self.view.addSubview(fitsizeView)
        fitsizeView.frame = CGRect(x: 0, y: redViewFrame~.maxY, width: 328~, height: 298~)
        
        portraitBtn.snp.makeConstraints { make in
            make.left.equalTo(redView.snp.right).offset(5)
            make.height.equalTo(50)
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

