//
//  SwiftyFitsize.swift
//  SwiftyFitsize
//
//  Created by LinXunFeng on 2018/10/17.
//  Copyright © 2018 siyu. All rights reserved.
//

import UIKit

fileprivate let ScreenW = UIScreen.main.bounds.width

public final class SwiftyFitsize {
    static let shared = SwiftyFitsize()
    private init() { }
    
    // default reference width 375
    private var referenceW: CGFloat = 375
    
    public static func reference(width: CGFloat) {
        SwiftyFitsize.shared.referenceW = width
    }
    
    fileprivate func fitSize(_ v: CGFloat) -> CGFloat {
        return ScreenW / referenceW * v
    }
}

postfix operator ~

public postfix func ~ (value: CGFloat) -> CGFloat {
    return SwiftyFitsize.shared.fitSize(value)
}

public postfix func ~ (font: UIFont) -> UIFont {
    return UIFont(name: font.fontName, size: font.pointSize~) ?? font
}
public postfix func ~ (value: Int) -> CGFloat {
    return CGFloat(value)~
}
public postfix func ~ (value: Float) -> CGFloat {
    return CGFloat(value)~
}
public postfix func ~ (value: CGPoint) -> CGPoint {
    return CGPoint(
        x: value.x~,
        y: value.y~
    )
}
public postfix func ~ (value: CGSize) -> CGSize {
    return CGSize(
        width: value.width~,
        height: value.height~
    )
}
public postfix func ~ (value: CGRect) -> CGRect {
    return CGRect(
        x: value.origin.x~,
        y: value.origin.y~,
        width: value.size.width~,
        height: value.size.height~
    )
}
public postfix func ~ (value: UIEdgeInsets) -> UIEdgeInsets {
    return UIEdgeInsetsMake(
        value.top~,
        value.left~,
        value.bottom~,
        value.right~
    )
}
