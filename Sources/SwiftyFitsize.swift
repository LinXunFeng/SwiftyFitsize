//
//  SwiftyFitsize.swift
//  SwiftyFitsize
//
//  Created by LinXunFeng on 2018/10/17.
//  Copyright © 2018 siyu. All rights reserved.
//

import UIKit

// MARK:- SwiftyFitsize
/*
 * ~  : 对比宽度，当设备为iPad时，适配后的 value 会再乘上 iPadFitMultiple
 * ≈  : 对比宽度，强制适配，不论是iPhone还是iPad 都不会乘上 iPadFitMultiple
 * ∣  : 对比高度，对应 ~ ，整屏高度
 * ∥  : 对比高度，对应 ≈ ，整屏高度
 * ∣= : 对比高度，对应 ∣ ，安全区域内的高度
 * ∥= : 对比高度，对应 ∥ ，安全区域内的高度
 * ∣- : 对比高度，对应 ∣ ，除去刘海区域的安全区域内的高度
 * ∥- : 对比高度，对应 ∥ ，除去刘海区域的安全区域内的高度
 */

@objc public enum SwiftyFitType: Int {
    /// Original Value
    case none = 0
    /// ~
    case flexibleWidth = 1
    /// ≈
    case forceWidth = 2
    /// ∣
    case flexibleHeight = 3
    /// ∥
    case forceHeight = 4
    /// ∣=
    case flexibleSafeAreaCenterHeight = 5
    /// ∥=
    case forceSafeAreaCenterHeight = 6
    /// ∣-
    case flexibleSafeAreaWithoutTopHeight = 7
    /// ∥-
    case forceSafeAreaWithoutTopHeight = 8
}

@objc public final class SwiftyFitsize: NSObject {
    static let shared = SwiftyFitsize()
    private override init() { }
    
    @objc public class func sharedSwiftyFitsize() -> SwiftyFitsize {
        return SwiftyFitsize.shared
    }
    
    /// 默认参照宽度
    @objc public private(set) var referenceW: CGFloat = 375
    /// 默认参照高度
    @objc public private(set) var referenceH: CGFloat = 667
    /// 是否为iPhoneX系列的参照高度，默认否
    @objc public private(set) var isIPhoneXSeriesHeight: Bool = false
    /// 默认 iPad 适配缩放倍数 (0 , 1]
    @objc public private(set) var iPadFitMultiple: CGFloat = 0.5
    /// 中间安全区域参照高度
    var referenceSafeAreaCenterHeight: CGFloat {
        if !isIPhoneXSeriesHeight { return referenceH }
        return referenceH - Config.Screen.safeAreaTopMargin - Config.Screen.safeAreaBottomMargin
    }
    /// 仅去除顶部后的安全区域参照高度
    var referenceSafeAreaWithoutTopHeight: CGFloat {
        if !isIPhoneXSeriesHeight { return referenceH }
        return referenceH - Config.Screen.safeAreaTopMargin
    }
    /// 适配倍数
    var fitMultiple: CGFloat {
        return Config.Device.isIPad ? SwiftyFitsize.shared.iPadFitMultiple : 1
    }
    
    /// 设置参照的相关参数
    ///
    /// - Parameters:
    ///   - width: 参照的宽度
    ///   - iPadFitMultiple: iPad 在适配后所得值的倍数 (0 , 1]
    @available(iOS, introduced: 0.3, deprecated: 1.1.0, message: "Use -[SwiftyFitsize referenceWithWidth:height:isIPhoneXSeriesHeight:iPadFitMultiple:]")
    @objc public static func reference(
        width: CGFloat,
        iPadFitMultiple: CGFloat
    ) {
        self.reference(width: width, height: 667, isIPhoneXSeriesHeight: false, iPadFitMultiple: iPadFitMultiple)
    }
    
    /// 设置参照的相关参数
    /// - Parameters:
    ///   - width: 参照的宽度
    ///   - height: 参照的高度
    ///   - isIPhoneXSeriesHeight: 是否为iPhoneX系列的参照高度
    ///   - iPadFitMultiple: iPad 在适配后所得值的倍数 (0 , 1]
    @objc public static func reference(
        width: CGFloat,
        height: CGFloat = 667,
        isIPhoneXSeriesHeight: Bool = false,
        iPadFitMultiple: CGFloat = 0.5
    ) {
        SwiftyFitsize.shared.referenceW = width
        SwiftyFitsize.shared.referenceH = height
        SwiftyFitsize.shared.isIPhoneXSeriesHeight = isIPhoneXSeriesHeight
        SwiftyFitsize.shared.iPadFitMultiple =
            (iPadFitMultiple > 1 || iPadFitMultiple < 0) ? 1 : iPadFitMultiple
    }
    
    fileprivate func fitNumberSize(
        _ value: CGFloat,
        fitType: SwiftyFitType
    ) -> CGFloat {
        switch fitType {
        case .none: return value
        case .flexibleWidth:
            return Config.Screen.width / referenceW * value * fitMultiple
        case .forceWidth:
            return Config.Screen.width / referenceW * value
        case .flexibleHeight:
            return Config.Screen.height / referenceH * value * fitMultiple
        case .forceHeight:
            return Config.Screen.height / referenceH * value
        case .flexibleSafeAreaCenterHeight:
            return Config.Screen.iPhoneXSeriesSafeAreaCenterHeight / referenceSafeAreaCenterHeight * value * fitMultiple
        case .forceSafeAreaCenterHeight:
            return Config.Screen.iPhoneXSeriesSafeAreaCenterHeight / referenceSafeAreaCenterHeight * value
        case .flexibleSafeAreaWithoutTopHeight:
            return Config.Screen.iPhoneXSeriesSafeAreaWithoutTopHeight / referenceSafeAreaWithoutTopHeight * value * fitMultiple
        case .forceSafeAreaWithoutTopHeight:
            return Config.Screen.iPhoneXSeriesSafeAreaWithoutTopHeight / referenceSafeAreaWithoutTopHeight * value
        }
    }
    
    fileprivate func fitFontSize(
        _ font : UIFont,
        type: SwiftyFitType
    ) -> UIFont {
        switch type {
        case .flexibleWidth: return font~
        case .forceWidth: return font≈
        case .flexibleHeight: return font∣
        case .forceHeight: return font∥
        case .flexibleSafeAreaCenterHeight: return font∣=
        case .forceSafeAreaCenterHeight: return font∥=
        case .flexibleSafeAreaWithoutTopHeight: return font∣-
        case .forceSafeAreaWithoutTopHeight: return font∥-
        default: return font
        }
    }
}

// MARK:- 运算符

// MARK: operator ~
postfix operator ~
public postfix func ~ (value: CGFloat) -> CGFloat {
    return value.sf(.flexibleWidth)
}
public postfix func ~ (font: UIFont) -> UIFont {
    return font.sf(.flexibleWidth)
}
public postfix func ~ (value: Int) -> CGFloat {
    return CGFloat(value).sf(.flexibleWidth)
}
public postfix func ~ (value: Float) -> CGFloat {
    return CGFloat(value).sf(.flexibleWidth)
}
public postfix func ~ (value: CGPoint) -> CGPoint {
    return value.sf(.flexibleWidth)
}
public postfix func ~ (value: CGSize) -> CGSize {
    return value.sf(.flexibleWidth)
}
public postfix func ~ (value: CGRect) -> CGRect {
    return value.sf(.flexibleWidth)
}
public postfix func ~ (value: UIEdgeInsets) -> UIEdgeInsets {
    return value.sf(.flexibleWidth)
}

// MARK: operator ≈
postfix operator ≈
public postfix func ≈ (value: CGFloat) -> CGFloat {
    return value.sf(.forceWidth)
}
public postfix func ≈ (font: UIFont) -> UIFont {
    return font.sf(.forceWidth)
}
public postfix func ≈ (value: Int) -> CGFloat {
    return CGFloat(value).sf(.forceWidth)
}
public postfix func ≈ (value: Float) -> CGFloat {
    return CGFloat(value).sf(.forceWidth)
}
public postfix func ≈ (value: CGPoint) -> CGPoint {
    return value.sf(.forceWidth)
}
public postfix func ≈ (value: CGSize) -> CGSize {
    return value.sf(.forceWidth)
}
public postfix func ≈ (value: CGRect) -> CGRect {
    return value.sf(.forceWidth)
}
public postfix func ≈ (value: UIEdgeInsets) -> UIEdgeInsets {
    return value.sf(.forceWidth)
}

// MARK: operator ∣
postfix operator ∣
public postfix func ∣ (value: CGFloat) -> CGFloat {
    return value.sf(.flexibleHeight)
}
public postfix func ∣ (font: UIFont) -> UIFont {
    return font.sf(.flexibleHeight)
}
public postfix func ∣ (value: Int) -> CGFloat {
    return CGFloat(value).sf(.flexibleHeight)
}
public postfix func ∣ (value: Float) -> CGFloat {
    return CGFloat(value).sf(.flexibleHeight)
}
public postfix func ∣ (value: CGPoint) -> CGPoint {
    return value.sf(.flexibleHeight)
}
public postfix func ∣ (value: CGSize) -> CGSize {
    return value.sf(.flexibleHeight)
}
public postfix func ∣ (value: CGRect) -> CGRect {
    return value.sf(.flexibleHeight)
}
public postfix func ∣ (value: UIEdgeInsets) -> UIEdgeInsets {
    return value.sf(.flexibleHeight)
}

// MARK: operator ∥
postfix operator ∥
public postfix func ∥ (value: CGFloat) -> CGFloat {
    return value.sf(.forceHeight)
}
public postfix func ∥ (font: UIFont) -> UIFont {
    return font.sf(.forceHeight)
}
public postfix func ∥ (value: Int) -> CGFloat {
    return CGFloat(value).sf(.forceHeight)
}
public postfix func ∥ (value: Float) -> CGFloat {
    return CGFloat(value).sf(.forceHeight)
}
public postfix func ∥ (value: CGPoint) -> CGPoint {
    return value.sf(.forceHeight)
}
public postfix func ∥ (value: CGSize) -> CGSize {
    return value.sf(.forceHeight)
}
public postfix func ∥ (value: CGRect) -> CGRect {
    return value.sf(.forceHeight)
}
public postfix func ∥ (value: UIEdgeInsets) -> UIEdgeInsets {
    return value.sf(.forceHeight)
}

// MARK: operator ∣=
postfix operator ∣=
public postfix func ∣= (value: CGFloat) -> CGFloat {
    return value.sf(.flexibleSafeAreaCenterHeight)
}
public postfix func ∣= (font: UIFont) -> UIFont {
    return font.sf(.flexibleSafeAreaCenterHeight)
}
public postfix func ∣= (value: Int) -> CGFloat {
    return CGFloat(value).sf(.flexibleSafeAreaCenterHeight)
}
public postfix func ∣= (value: Float) -> CGFloat {
    return CGFloat(value).sf(.flexibleSafeAreaCenterHeight)
}
public postfix func ∣= (value: CGPoint) -> CGPoint {
    return value.sf(.flexibleSafeAreaCenterHeight)
}
public postfix func ∣= (value: CGSize) -> CGSize {
    return value.sf(.flexibleSafeAreaCenterHeight)
}
public postfix func ∣= (value: CGRect) -> CGRect {
    return value.sf(.flexibleSafeAreaCenterHeight)
}
public postfix func ∣= (value: UIEdgeInsets) -> UIEdgeInsets {
    return value.sf(.flexibleSafeAreaCenterHeight)
}

// MARK: operator ∥=
postfix operator ∥=
public postfix func ∥= (value: CGFloat) -> CGFloat {
    return value.sf(.forceSafeAreaCenterHeight)
}
public postfix func ∥= (font: UIFont) -> UIFont {
    return font.sf(.forceSafeAreaCenterHeight)
}
public postfix func ∥= (value: Int) -> CGFloat {
    return CGFloat(value).sf(.forceSafeAreaCenterHeight)
}
public postfix func ∥= (value: Float) -> CGFloat {
    return CGFloat(value).sf(.forceSafeAreaCenterHeight)
}
public postfix func ∥= (value: CGPoint) -> CGPoint {
    return value.sf(.forceSafeAreaCenterHeight)
}
public postfix func ∥= (value: CGSize) -> CGSize {
    return value.sf(.forceSafeAreaCenterHeight)
}
public postfix func ∥= (value: CGRect) -> CGRect {
    return value.sf(.forceSafeAreaCenterHeight)
}
public postfix func ∥= (value: UIEdgeInsets) -> UIEdgeInsets {
    return value.sf(.forceSafeAreaCenterHeight)
}

// MARK: operator ∣-
postfix operator ∣-
public postfix func ∣- (value: CGFloat) -> CGFloat {
    return value.sf(.flexibleSafeAreaWithoutTopHeight)
}
public postfix func ∣- (font: UIFont) -> UIFont {
    return font.sf(.flexibleSafeAreaWithoutTopHeight)
}
public postfix func ∣- (value: Int) -> CGFloat {
    return CGFloat(value).sf(.flexibleSafeAreaWithoutTopHeight)
}
public postfix func ∣- (value: Float) -> CGFloat {
    return CGFloat(value).sf(.flexibleSafeAreaWithoutTopHeight)
}
public postfix func ∣- (value: CGPoint) -> CGPoint {
    return value.sf(.flexibleSafeAreaWithoutTopHeight)
}
public postfix func ∣- (value: CGSize) -> CGSize {
    return value.sf(.flexibleSafeAreaWithoutTopHeight)
}
public postfix func ∣- (value: CGRect) -> CGRect {
    return value.sf(.flexibleSafeAreaWithoutTopHeight)
}
public postfix func ∣- (value: UIEdgeInsets) -> UIEdgeInsets {
    return value.sf(.flexibleSafeAreaWithoutTopHeight)
}

// MARK: operator ∥-
postfix operator ∥-
public postfix func ∥- (value: CGFloat) -> CGFloat {
    return value.sf(.forceSafeAreaWithoutTopHeight)
}
public postfix func ∥- (font: UIFont) -> UIFont {
    return font.sf(.forceSafeAreaWithoutTopHeight)
}
public postfix func ∥- (value: Int) -> CGFloat {
    return CGFloat(value).sf(.forceSafeAreaWithoutTopHeight)
}
public postfix func ∥- (value: Float) -> CGFloat {
    return CGFloat(value).sf(.forceSafeAreaWithoutTopHeight)
}
public postfix func ∥- (value: CGPoint) -> CGPoint {
    return value.sf(.forceSafeAreaWithoutTopHeight)
}
public postfix func ∥- (value: CGSize) -> CGSize {
    return value.sf(.forceSafeAreaWithoutTopHeight)
}
public postfix func ∥- (value: CGRect) -> CGRect {
    return value.sf(.forceSafeAreaWithoutTopHeight)
}
public postfix func ∥- (value: UIEdgeInsets) -> UIEdgeInsets {
    return value.sf(.forceSafeAreaWithoutTopHeight)
}

// MARK:- 辅助拓展
extension CGFloat {
    func sf(_ type: SwiftyFitType) -> CGFloat {
        return SwiftyFitsize.shared.fitNumberSize(self, fitType: type)
    }
}
extension UIFont {
    func sf(_ type: SwiftyFitType) -> UIFont {
        return self.withSize(self.pointSize.sf(type))
    }
}
extension CGPoint {
    func sf(_ type: SwiftyFitType) -> CGPoint {
        return CGPoint(x: x.sf(type), y: y.sf(type))
    }
}
extension CGSize {
    func sf(_ type: SwiftyFitType) -> CGSize {
        return CGSize(width: width.sf(type), height: height.sf(type))
    }
}
extension CGRect {
    func sf(_ type: SwiftyFitType) -> CGRect {
        return CGRect(
            x: origin.x.sf(type),
            y: origin.y.sf(type),
            width: size.width.sf(type),
            height: size.height.sf(type)
        )
    }
}
extension UIEdgeInsets {
    func sf(_ type: SwiftyFitType) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: top.sf(type),
            left: left.sf(type),
            bottom: bottom.sf(type),
            right: right.sf(type)
        )
    }
}

// MARK:- Xib/Storyboard
public extension NSLayoutConstraint {
    @IBInspectable var swiftyFitType: Int {
        get { return SwiftyFitType.none.rawValue }
        set {
            guard let type = SwiftyFitType(rawValue: newValue) else { return }
            constant = SwiftyFitsize.shared.fitNumberSize(constant, fitType: type)
        }
    }
}
public extension UILabel {
    @IBInspectable var fontFitType: Int {
        get { return SwiftyFitType.none.rawValue }
        set {
            guard let type = SwiftyFitType(rawValue: newValue) else { return }
            guard let xfont = font else { return }
            self.font = SwiftyFitsize.shared.fitFontSize(xfont, type: type)
        }
    }
}
public extension UITextView {
    @IBInspectable var fontFitType: Int {
        get { return SwiftyFitType.none.rawValue }
        set {
            guard let type = SwiftyFitType(rawValue: newValue) else { return }
            guard let xfont = font else { return }
            self.font = SwiftyFitsize.shared.fitFontSize(xfont, type: type)
        }
    }
}
public extension UITextField {
    @IBInspectable var fontFitType: Int {
        get { return SwiftyFitType.none.rawValue }
        set {
            guard let type = SwiftyFitType(rawValue: newValue) else { return }
            guard let xfont = font else { return }
            self.font = SwiftyFitsize.shared.fitFontSize(xfont, type: type)
        }
    }
}
public extension UIButton {
    @IBInspectable var fontFitType: Int {
        get { return SwiftyFitType.none.rawValue }
        set {
            guard let type = SwiftyFitType(rawValue: newValue) else { return }
            guard let xfont = titleLabel?.font else { return }
            self.titleLabel?.font = SwiftyFitsize.shared.fitFontSize(xfont, type: type)
        }
    }
}


// MARK:- OC
public extension UIFont {
    @objc var sf: UIFont { return self~ }
    @objc var sfz: UIFont { return self≈ }
    @objc var sf_fh: UIFont { return self∣ }
    @objc var sfz_fh: UIFont { return self∥ }
    @objc var sf_sch: UIFont { return self∣= }
    @objc var sfz_sch: UIFont { return self∥= }
    @objc var sf_sbh: UIFont { return self∣- }
    @objc var sfz_sbh: UIFont { return self∥- }
}
public extension SwiftyFitsize {
    @objc func sf_int(_ value: Int) -> CGFloat {
        return value~
    }
    @objc func sf_float(_ value: CGFloat) -> CGFloat {
        return value~
    }
    @objc func sf_point(_ value: CGPoint) -> CGPoint {
        return value~
    }
    @objc func sf_size(_ value: CGSize) -> CGSize {
        return value~
    }
    @objc func sf_rect(_ value: CGRect) -> CGRect {
        return value~
    }
    @objc func sf_EdgeInsets(_ value: UIEdgeInsets) -> UIEdgeInsets {
        return value~
    }
    
    @objc func sfz_int(_ value: Int) -> CGFloat {
        return value≈
    }
    @objc func sfz_float(_ value: CGFloat) -> CGFloat {
        return value≈
    }
    @objc func sfz_point(_ value: CGPoint) -> CGPoint {
        return value≈
    }
    @objc func sfz_size(_ value: CGSize) -> CGSize {
        return value≈
    }
    @objc func sfz_rect(_ value: CGRect) -> CGRect {
        return value≈
    }
    @objc func sfz_EdgeInsets(_ value: UIEdgeInsets) -> UIEdgeInsets {
        return value≈
    }
    
    // fh: full height
    @objc func sf_fh_int(_ value: Int) -> CGFloat {
        return value∣
    }
    @objc func sf_fh_float(_ value: CGFloat) -> CGFloat {
        return value∣
    }
    @objc func sf_fh_point(_ value: CGPoint) -> CGPoint {
        return value∣
    }
    @objc func sf_fh_size(_ value: CGSize) -> CGSize {
        return value∣
    }
    @objc func sf_fh_rect(_ value: CGRect) -> CGRect {
        return value∣
    }
    @objc func sf_fh_EdgeInsets(_ value: UIEdgeInsets) -> UIEdgeInsets {
        return value∣
    }
    
    @objc func sfz_fh_int(_ value: Int) -> CGFloat {
        return value∥
    }
    @objc func sfz_fh_float(_ value: CGFloat) -> CGFloat {
        return value∥
    }
    @objc func sfz_fh_point(_ value: CGPoint) -> CGPoint {
        return value∥
    }
    @objc func sfz_fh_size(_ value: CGSize) -> CGSize {
        return value∥
    }
    @objc func sfz_fh_rect(_ value: CGRect) -> CGRect {
        return value∥
    }
    @objc func sfz_fh_EdgeInsets(_ value: UIEdgeInsets) -> UIEdgeInsets {
        return value∥
    }
    
    // sch: safeArea center height
    @objc func sf_sch_int(_ value: Int) -> CGFloat {
        return value∣=
    }
    @objc func sf_sch_float(_ value: CGFloat) -> CGFloat {
        return value∣=
    }
    @objc func sf_sch_point(_ value: CGPoint) -> CGPoint {
        return value∣=
    }
    @objc func sf_sch_size(_ value: CGSize) -> CGSize {
        return value∣=
    }
    @objc func sf_sch_rect(_ value: CGRect) -> CGRect {
        return value∣=
    }
    @objc func sf_sch_EdgeInsets(_ value: UIEdgeInsets) -> UIEdgeInsets {
        return value∣=
    }
    
    @objc func sfz_sch_int(_ value: Int) -> CGFloat {
        return value∥=
    }
    @objc func sfz_sch_float(_ value: CGFloat) -> CGFloat {
        return value∥=
    }
    @objc func sfz_sch_point(_ value: CGPoint) -> CGPoint {
        return value∥=
    }
    @objc func sfz_sch_size(_ value: CGSize) -> CGSize {
        return value∥=
    }
    @objc func sfz_sch_rect(_ value: CGRect) -> CGRect {
        return value∥=
    }
    @objc func sfz_sch_EdgeInsets(_ value: UIEdgeInsets) -> UIEdgeInsets {
        return value∥=
    }
    
    // sbh: safeArea bottom height
    @objc func sf_sbh_int(_ value: Int) -> CGFloat {
        return value∣-
    }
    @objc func sf_sbh_float(_ value: CGFloat) -> CGFloat {
        return value∣-
    }
    @objc func sf_sbh_point(_ value: CGPoint) -> CGPoint {
        return value∣-
    }
    @objc func sf_sbh_size(_ value: CGSize) -> CGSize {
        return value∣-
    }
    @objc func sf_sbh_rect(_ value: CGRect) -> CGRect {
        return value∣-
    }
    @objc func sf_sbh_EdgeInsets(_ value: UIEdgeInsets) -> UIEdgeInsets {
        return value∣-
    }
    
    @objc func sfz_sbh_int(_ value: Int) -> CGFloat {
        return value∥-
    }
    @objc func sfz_sbh_float(_ value: CGFloat) -> CGFloat {
        return value∥-
    }
    @objc func sfz_sbh_point(_ value: CGPoint) -> CGPoint {
        return value∥-
    }
    @objc func sfz_sbh_size(_ value: CGSize) -> CGSize {
        return value∥-
    }
    @objc func sfz_sbh_rect(_ value: CGRect) -> CGRect {
        return value∥-
    }
    @objc func sfz_sbh_EdgeInsets(_ value: UIEdgeInsets) -> UIEdgeInsets {
        return value∥-
    }
}


// MARK:- Config
fileprivate struct Config {
    struct Screen {
        private static let sw: CGFloat = UIScreen.main.bounds.width
        private static let sh: CGFloat = UIScreen.main.bounds.height
        
        static let width: CGFloat = sw < sh ? sw : sh
        static let height: CGFloat = sw < sh ? sh : sw
        
        static var safeAreaTopMargin: CGFloat {
            return Device.getSafeAreaTopMargin()
        }
        static var safeAreaBottomMargin: CGFloat {
            Device.getSafeAreaBottomMargin()
        }
        static var iPhoneXSeriesSafeAreaCenterHeight: CGFloat {
            return height - safeAreaTopMargin - safeAreaBottomMargin
        }
        static var iPhoneXSeriesSafeAreaWithoutTopHeight: CGFloat {
            return height - safeAreaTopMargin
        }
    }
    struct Device {
        static let isIPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
        static let isIphneXSeries = isIPhoneXSeries()
        
        static func getCurrentWindow() -> UIWindow? {
            if let window = UIApplication.shared.delegate?.window {
                return window
            }
            if #available(iOS 13.0, *) {
                if let windowScene = UIApplication.shared.connectedScenes.first {
                    if let mainWindow = windowScene.value(forKey: "delegate.window") as? UIWindow {
                        return mainWindow
                    }
                    return UIApplication.shared.windows.last
                }
            }
            return UIApplication.shared.keyWindow
        }
        
        /// 是否是iphoneX系列
        static private func isIPhoneXSeries() -> Bool {
            var bottomSafeInset: CGFloat = 0
            if #available(iOS 11.0, *) {
                bottomSafeInset = getCurrentWindow()?.safeAreaInsets.bottom ?? 0
            }
            return bottomSafeInset > 0
        }
        
        /// 当前是否是竖屏
        static func isPortrait() -> Bool {
            return UIApplication.shared.statusBarOrientation.isPortrait
        }
        
        static func getSafeAreaInsets() -> UIEdgeInsets {
            var safeAreaInsets: UIEdgeInsets = .zero
            if #available(iOS 11.0, *) {
                guard let inset = getCurrentWindow()?.safeAreaInsets else { return .zero }
                safeAreaInsets = inset
            }
            return safeAreaInsets
        }
        
        /// 安全区域刘海一侧的间距
        static func getSafeAreaTopMargin() -> CGFloat {
            let inset = getSafeAreaInsets()
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown: return inset.top
            case .landscapeLeft: return inset.right
            case .landscapeRight: return inset.left
            default: return 0
            }
        }
            
        /// 安全区域刘海对侧的间距
        static func getSafeAreaBottomMargin() -> CGFloat {
            let inset = getSafeAreaInsets()
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown: return inset.bottom
            case .landscapeLeft: return inset.left
            case .landscapeRight: return inset.right
            default: return 0
            }
        }
    }
}
