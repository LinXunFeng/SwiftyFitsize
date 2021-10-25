//
//  SwiftyFitsize.swift
//  SwiftyFitsize
//
//  Created by LinXunFeng on 2018/10/17.
//  Copyright © 2018 siyu. All rights reserved.
//

import UIKit

// MARK:- SwiftyFitsize
@objc public final class SwiftyFitsize: NSObject {
    public static let shared = SwiftyFitsize()
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
    /// 计算结果类型（默认: 原始数据）
    @objc public private(set) var calcResultType: SwiftyFitCalcResultType = .raw
    
    /// 中间安全区域参照高度
    var referenceSafeAreaCenterHeight: CGFloat {
        return self.fetchReferenceSafeAreaCenterHeight()
    }
    /// 仅去除顶部后的安全区域参照高度
    var referenceSafeAreaWithoutTopHeight: CGFloat {
        return self.fetchReferenceSafeAreaWithoutTopHeight()
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
    ///   - calcResultType: 计算结果类型（默认：原始数据），如果传入的是.globalConfig，则会修改为.raw
    @objc public static func reference(
        width: CGFloat,
        height: CGFloat = 667,
        isIPhoneXSeriesHeight: Bool = false,
        iPadFitMultiple: CGFloat = 0.5,
        calcResultType: SwiftyFitCalcResultType = .raw
    ) {
        SwiftyFitsize.shared.referenceW = width
        SwiftyFitsize.shared.referenceH = height
        SwiftyFitsize.shared.isIPhoneXSeriesHeight = isIPhoneXSeriesHeight
        SwiftyFitsize.shared.iPadFitMultiple =
            (iPadFitMultiple > 1 || iPadFitMultiple < 0) ? 1 : iPadFitMultiple
        
        var finalCalcResultType: SwiftyFitCalcResultType = calcResultType
        switch calcResultType {
        case .globalConfig: finalCalcResultType = .raw
        default: break
        }
        SwiftyFitsize.shared.calcResultType = finalCalcResultType
    }
    
    /// 适配方法
    /// - Parameters:
    ///   - size: 大小
    ///   - fitType: 适配方式
    ///   - reduceValue: 要额外减少的数值
    /// - Returns: 适配后的数值
    @objc public static func fit(
        size: CGFloat,
        fitType: SwiftyFitType,
        reduceValue: CGFloat = 0
    ) -> CGFloat {
        return Self.fit(
            size: size,
            fitType: fitType,
            reduceValue: reduceValue,
            calcResultType: .globalConfig
        )
    }
    
    /// 适配方法
    /// - Parameters:
    ///   - size: 大小
    ///   - fitType: 适配方式
    ///   - reduceValue: 要额外减少的数值
    ///   - calcResultType: 计算结果类型（默认: 跟随全局配置）
    /// - Returns: 适配后的数值
    @objc public static func fit(
        size: CGFloat,
        fitType: SwiftyFitType,
        reduceValue: CGFloat = 0,
        calcResultType: SwiftyFitCalcResultType = .globalConfig
    ) -> CGFloat {
        return Self.shared.fitNumberSize(
            size,
            fitType: fitType,
            reduceValue: reduceValue,
            calcResultType: calcResultType
        )
    }
    
    /// 适配方法
    /// - Parameters:
    ///   - size: 大小
    ///   - fitType: 适配方式
    ///   - referenceWidth: 参照的宽度
    ///   - referenceHeight: 参照的高度
    ///   - isIPhoneXSeriesHeight: 参照的高度是否为iPhoneX系列
    ///   - reduceValue: 要额外减少的数值
    ///   - calcResultType: 计算结果类型（默认: 跟随全局配置）
    /// - Returns: 适配后的数值
    @objc public static func fit(
        size: CGFloat,
        fitType: SwiftyFitType,
        referenceWidth: CGFloat = SwiftyFitsize.shared.referenceW,
        referenceHeight: CGFloat = SwiftyFitsize.shared.referenceH,
        isIPhoneXSeriesHeight: Bool = SwiftyFitsize.shared.isIPhoneXSeriesHeight,
        reduceValue: CGFloat = 0,
        calcResultType: SwiftyFitCalcResultType = .globalConfig
    ) -> CGFloat {
        return Self.shared.fitNumberSize(
            size,
            fitType: fitType,
            referenceWidth: referenceWidth,
            referenceHeight: referenceHeight,
            isIPhoneXSeriesHeight: isIPhoneXSeriesHeight,
            reduceValue: reduceValue,
            calcResultType: calcResultType
        )
    }
    
    /// 适配的核心计算方法
    /// - Parameters:
    ///   - value: 需要适配的数值
    ///   - fitType: 适配方式
    ///   - referenceWidth: 参照的宽度
    ///   - referenceHeight: 参照的高度
    ///   - isIPhoneXSeriesHeight: 参照的高度是否为iPhoneX系列
    ///   - reduceValue: 减少的数值（默认: 0）
    ///   - calcResultType: 计算结果类型（默认: 跟随全局配置）
    /// - Returns: 适配后的数值
    fileprivate func fitNumberSize(
        _ value: CGFloat,
        fitType: SwiftyFitType,
        referenceWidth: CGFloat = SwiftyFitsize.shared.referenceW,
        referenceHeight: CGFloat = SwiftyFitsize.shared.referenceH,
        isIPhoneXSeriesHeight: Bool = SwiftyFitsize.shared.isIPhoneXSeriesHeight,
        reduceValue: CGFloat = 0,
        calcResultType: SwiftyFitCalcResultType = .globalConfig
    ) -> CGFloat {
        var calcResult: CGFloat
        
        switch fitType {
        case .none: return value
        case .flexibleWidth:
            let currentWidth = Config.Screen.width - reduceValue
            let finalReferenceW = referenceWidth - reduceValue
            calcResult = currentWidth / finalReferenceW * value * fitMultiple
        case .forceWidth:
            let currentWidth = Config.Screen.width - reduceValue
            let finalReferenceW = referenceWidth - reduceValue
            calcResult = currentWidth / finalReferenceW * value
        case .flexibleHeight:
            let currentHeight = Config.Screen.height - reduceValue
            let finalReferenceH = referenceHeight - reduceValue
            calcResult = currentHeight / finalReferenceH * value * fitMultiple
        case .forceHeight:
            let currentHeight = Config.Screen.height - reduceValue
            let finalReferenceH = referenceHeight - reduceValue
            calcResult = currentHeight / finalReferenceH * value
        case .flexibleSafeAreaCenterHeight:
            let referenceSafeAreaCenterHeight = self.fetchReferenceSafeAreaCenterHeight(
                isIPhoneXSeriesHeight: isIPhoneXSeriesHeight,
                referenceHeight: referenceHeight
            )
            let currentHeight = Config.Screen.iPhoneXSeriesSafeAreaCenterHeight - reduceValue
            let finalReferenceH = referenceSafeAreaCenterHeight - reduceValue
            calcResult = currentHeight / finalReferenceH * value * fitMultiple
        case .forceSafeAreaCenterHeight:
            let referenceSafeAreaCenterHeight = self.fetchReferenceSafeAreaCenterHeight(
                isIPhoneXSeriesHeight: isIPhoneXSeriesHeight,
                referenceHeight: referenceHeight
            )
            let currentHeight = Config.Screen.iPhoneXSeriesSafeAreaCenterHeight - reduceValue
            let finalReferenceH = referenceSafeAreaCenterHeight - reduceValue
            calcResult = currentHeight / finalReferenceH * value
        case .flexibleSafeAreaWithoutTopHeight:
            let referenceSafeAreaWithoutTopHeight = self.fetchReferenceSafeAreaWithoutTopHeight(
                isIPhoneXSeriesHeight: isIPhoneXSeriesHeight,
                referenceHeight: referenceHeight
            )
            let currentHeight = Config.Screen.iPhoneXSeriesSafeAreaWithoutTopHeight - reduceValue
            let finalReferenceH = referenceSafeAreaWithoutTopHeight - reduceValue
            calcResult = currentHeight / finalReferenceH * value * fitMultiple
        case .forceSafeAreaWithoutTopHeight:
            let referenceSafeAreaWithoutTopHeight = self.fetchReferenceSafeAreaWithoutTopHeight(
                isIPhoneXSeriesHeight: isIPhoneXSeriesHeight,
                referenceHeight: referenceHeight
            )
            let currentHeight = Config.Screen.iPhoneXSeriesSafeAreaWithoutTopHeight - reduceValue
            let finalReferenceH = referenceSafeAreaWithoutTopHeight - reduceValue
            calcResult = currentHeight / finalReferenceH * value
        }
        
        // 根据指定的计算结果类型计算最终的值
        let finalCalcResultType: SwiftyFitCalcResultType
        if calcResultType == .globalConfig {
            finalCalcResultType = SwiftyFitsize.shared.calcResultType
        } else {
            finalCalcResultType = calcResultType
        }
        switch finalCalcResultType {
        case .globalConfig, .raw: // 原始数据
            break
        case .round: // 四舍五入
            calcResult = round(calcResult)
        case .oneDecimalPlace: // 保留一位小数
            calcResult = round(calcResult * 10) / 10
        }
        
        return calcResult
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
    
    /// 获取中间安全区域参照高度
    fileprivate func fetchReferenceSafeAreaCenterHeight(
        isIPhoneXSeriesHeight: Bool = SwiftyFitsize.shared.isIPhoneXSeriesHeight,
        referenceHeight: CGFloat = SwiftyFitsize.shared.referenceH
    ) -> CGFloat {
        if !isIPhoneXSeriesHeight { return referenceHeight }
        return referenceHeight - Config.Screen.safeAreaTopMargin - Config.Screen.safeAreaBottomMargin
    }
    
    /// 获取仅去除顶部后的安全区域参照高度
    fileprivate func fetchReferenceSafeAreaWithoutTopHeight(
        isIPhoneXSeriesHeight: Bool = SwiftyFitsize.shared.isIPhoneXSeriesHeight,
        referenceHeight: CGFloat = SwiftyFitsize.shared.referenceH
    ) -> CGFloat {
        if !isIPhoneXSeriesHeight { return referenceHeight }
        return referenceHeight - Config.Screen.safeAreaTopMargin
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
