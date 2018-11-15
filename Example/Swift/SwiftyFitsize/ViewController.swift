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
        
        self.view.addSubview(fitLabel)
        self.view.addSubview(redView)
        
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
    }
}

