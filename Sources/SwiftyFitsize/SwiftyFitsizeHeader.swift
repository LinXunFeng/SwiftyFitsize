//
//  SwiftyFitsizeHeader.swift
//  Pods
//
//  Created by LinXunFeng on 2021/10/16.
//

import Foundation

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

/// 计算结果类型
@objc public enum SwiftyFitCalcResultType: Int {
    /// 跟随全局配置
    case globalConfig
    /// 原始数据
    case raw
    /// 四舍五入
    case round
    /// 保留一位小数（根据第二位小数进行四舍五入）
    case oneDecimalPlace
}
