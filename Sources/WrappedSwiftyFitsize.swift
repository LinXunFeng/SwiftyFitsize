//
//  WrappedSwiftyFitsize.swift
//  SwiftyFitsize
//
//  Created by LinXunFeng on 2021/8/21.
//

import Foundation

@propertyWrapper
public struct WrappedSwiftyFitsize {
    /// 最终计算好的数值
    private var value: CGFloat = 0
    /// 要减少的数值
    private var reduceValue: CGFloat
    /// 适配类型
    private let fitType: SwiftyFitType
    
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
        reduceValue: CGFloat = 0
    ) {
        self.reduceValue = reduceValue
        self.fitType = fitType
        self.value = self.calcValue(with: wrappedValue)
    }
    
    public func calcValue(with value: CGFloat) -> CGFloat {
        return SwiftyFitsize.fit(
            size: value,
            fitType: self.fitType,
            reduceValue: self.reduceValue
        )
    }
    
}
