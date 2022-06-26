//
//  WrappedSwiftyFitsize.swift
//  SwiftyFitsize
//
//  Created by LinXunFeng on 2021/8/21.
//

import CoreGraphics
import Foundation

@propertyWrapper
public struct WrappedSwiftyFitsize {
    /// 最终计算好的数值
    private var value: CGFloat = 0
    /// 要减少的数值
    private var reduceValue: CGFloat
    /// 适配类型
    private let fitType: SwiftyFitType
    /// 指定的参照宽度（默认: 全局设置的值）
    private let referenceWidth: CGFloat
    /// 指定的参照高度（默认: 全局设置的值）
    private let referenceHeight: CGFloat
    /// 指定的参照亮度（默认: 全局设置的值）
    private let isIPhoneXSeriesHeight: Bool
    /// 计算结果类型
    private let calcResultType: SwiftyFitCalcResultType
    
    public lazy var projectedValue: ((CGFloat) -> CGFloat) = {
       return calcValue
    }()
    
    public var wrappedValue: CGFloat {
        get {
            return value
        }
        set {
            self.value = self.calcValue(with: newValue)
        }
    }
    
    public init(
        wrappedValue: CGFloat = 0,
        fitType: SwiftyFitType = .flexibleWidth,
        referenceWidth: CGFloat = SwiftyFitsize.shared.referenceW,
        referenceHeight: CGFloat = SwiftyFitsize.shared.referenceH,
        isIPhoneXSeriesHeight: Bool = SwiftyFitsize.shared.isIPhoneXSeriesHeight,
        reduceValue: CGFloat = 0,
        calcResultType: SwiftyFitCalcResultType = .globalConfig
    ) {
        self.reduceValue = reduceValue
        self.referenceWidth = referenceWidth
        self.referenceHeight = referenceHeight
        self.isIPhoneXSeriesHeight = isIPhoneXSeriesHeight
        self.fitType = fitType
        self.calcResultType = calcResultType
        self.value = self.calcValue(with: wrappedValue)
    }
    
    public func calcValue(with value: CGFloat) -> CGFloat {
        return SwiftyFitsize.fit(
            size: value,
            fitType: self.fitType,
            referenceWidth: self.referenceWidth,
            referenceHeight: self.referenceHeight,
            isIPhoneXSeriesHeight: isIPhoneXSeriesHeight,
            reduceValue: self.reduceValue,
            calcResultType: self.calcResultType
        )
    }
    
}
