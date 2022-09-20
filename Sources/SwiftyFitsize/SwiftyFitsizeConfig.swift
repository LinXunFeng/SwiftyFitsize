//
//  SwiftyFitsizeConfig.swift
//  SwiftyFitsize
//
//  Created by LinXunFeng on 2021/8/21.
//

import CoreGraphics
import Foundation
import UIKit

// MARK:- Config
extension SwiftyFitsize {
    public struct Config {
        // MARK: Screen
        public struct Screen {
            private static let sw: CGFloat = UIScreen.main.bounds.width
            private static let sh: CGFloat = UIScreen.main.bounds.height
            
            public static let width: CGFloat = sw < sh ? sw : sh
            public static let height: CGFloat = sw < sh ? sh : sw
            
            public static var safeAreaTopMargin: CGFloat {
                return Device.getSafeAreaTopMargin()
            }
            public static var safeAreaBottomMargin: CGFloat {
                Device.getSafeAreaBottomMargin()
            }
            public static var iPhoneXSeriesSafeAreaCenterHeight: CGFloat {
                return height - safeAreaTopMargin - safeAreaBottomMargin
            }
            public static var iPhoneXSeriesSafeAreaWithoutTopHeight: CGFloat {
                return height - safeAreaTopMargin
            }
        }
        
        // MARK: Device
        public struct Device {
            public static let isIPad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
            public static let isIphneXSeries = isIPhoneXSeries()
            
            public static func getCurrentWindow() -> UIWindow? {
                if let window = UIApplication.shared.delegate?.window {
                    return window
                }
                if #available(iOS 13.0, *) {
                    if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first {
                        return window
                    }
                }
                return UIApplication.shared.keyWindow
            }
            
            /// 是否是iphoneX系列
            public static func isIPhoneXSeries() -> Bool {
                var bottomSafeInset: CGFloat = 0
                if #available(iOS 11.0, *) {
                    bottomSafeInset = getCurrentWindow()?.safeAreaInsets.bottom ?? 0
                }
                return bottomSafeInset > 0
            }
            
            /// 当前是否是竖屏
            public static func isPortrait() -> Bool {
                return UIApplication.shared.statusBarOrientation.isPortrait
            }
            
            public static func getSafeAreaInsets() -> UIEdgeInsets {
                var safeAreaInsets: UIEdgeInsets = .zero
                if #available(iOS 11.0, *) {
                    guard let inset = getCurrentWindow()?.safeAreaInsets else { return .zero }
                    safeAreaInsets = inset
                }
                return safeAreaInsets
            }
            
            /// 安全区域刘海一侧的间距
            public static func getSafeAreaTopMargin() -> CGFloat {
                let inset = getSafeAreaInsets()
                switch UIApplication.shared.statusBarOrientation {
                case .portrait, .portraitUpsideDown: return inset.top
                case .landscapeLeft: return inset.right
                case .landscapeRight: return inset.left
                default: return 0
                }
            }
                
            /// 安全区域刘海对侧的间距
            public static func getSafeAreaBottomMargin() -> CGFloat {
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
}

