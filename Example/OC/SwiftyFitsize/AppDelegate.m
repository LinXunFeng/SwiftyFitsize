//
//  AppDelegate.m
//  SwiftyFitsize-OC
//
//  Created by LinXunFeng on 2018/11/15.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

#import "AppDelegate.h"
@import SwiftyFitsize;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 全局配置
    [SwiftyFitsize referenceWithWidth:414 // 参照的宽度
                               height:896 // 参照的高度
                isIPhoneXSeriesHeight:YES // 参照的设置是否为 x 系列
                      iPadFitMultiple:0.6 // ipad系数
                       calcResultType:SwiftyFitCalcResultTypeRound]; // 计算结果类型（这里指定：四舍五入）
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
