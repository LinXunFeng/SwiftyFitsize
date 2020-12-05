//
//  ViewController.m
//  SwiftyFitsize-OC
//
//  Created by LinXunFeng on 2018/11/15.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

#import "ViewController.h"
@import SwiftyFitsize;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // CGFloat referenceW = [SwiftyFitsize sharedSwiftyFitsize].referenceW;
    // [SwiftyFitsize referenceWithWidth:414 iPadFitMultiple:0.6]; // 该方法过期
    [SwiftyFitsize referenceWithWidth:414 height:896 isIPhoneXSeriesHeight:YES iPadFitMultiple:0.6];
    
#pragma mark UIFont
    UIFont *font = [UIFont systemFontOfSize:14];
    // 以宽适配
    UIFont *font1 = font.sf;
    UIFont *font2 = font.sfz;
    // 以高适配（全屏）
    UIFont *font3 = font.sf_fh;
    UIFont *font4 = font.sfz_fh;
    // 以高适配（安全区域，仅中间）
    UIFont *font5 = font.sf_sch;
    UIFont *font6 = font.sfz_sch;
    // 以高适配（安全区域，不包括刘海）
    UIFont *font7 = font.sf_sbh;
    UIFont *font8 = font.sfz_sbh;
    
    // 以宽适配
    UIFont *font9 = SF_Font(font);
    UIFont *font10 = SFZ_Font(font);
    // 以高适配（全屏）
    UIFont *font11 = SF_FH_Font(font);
    UIFont *font12 = SFZ_FH_Font(font);
    // 以高适配（安全区域，仅中间）
    UIFont *font13 = SF_SCH_Font(font);
    UIFont *font14 = SFZ_SCH_Font(font);
    // 以高适配（安全区域，不包括刘海）
    UIFont *font15 = SF_SBH_Font(font);
    UIFont *font16 = SFZ_SBH_Font(font);
    
#pragma mark CGFloat
    CGFloat num = 14;
    // 以宽适配
    CGFloat num1 = SF_Float(num);
    CGFloat num2 = SFZ_Float(num);
    // 以高适配（全屏）
    CGFloat num3 = SF_FH_Float(num);
    CGFloat num4 = SFZ_FH_Float(num);
    // 以高适配（安全区域，仅中间）
    CGFloat num5 = SF_SCH_Float(num);
    CGFloat num6 = SFZ_SCH_Float(num);
    // 以高适配（安全区域，不包括刘海）
    CGFloat num7 = SF_SBH_Float(num);
    CGFloat num8 = SFZ_SBH_Float(num);
    
#pragma mark CGPoint
    CGPoint point = CGPointMake(10, 10);
    // 以宽适配
    CGPoint point1 = SF_Point(point);
    CGPoint point2 = SFZ_Point(point);
    // 以高适配（全屏）
    CGPoint point3 = SF_FH_Point(point);
    CGPoint point4 = SFZ_FH_Point(point);
    // 以高适配（安全区域，仅中间）
    CGPoint point5 = SF_SCH_Point(point);
    CGPoint point6 = SFZ_SCH_Point(point);
    // 以高适配（安全区域，不包括刘海）
    CGPoint point7 = SF_SBH_Point(point);
    CGPoint point8 = SFZ_SBH_Point(point);
    
#pragma mark CGSize
    CGSize size = CGSizeMake(100, 100);
    // 以宽适配
    CGSize size1 = SF_Size(size);
    CGSize size2 = SFZ_Size(size);
    // 以高适配（全屏）
    CGSize size3 = SF_FH_Size(size);
    CGSize size4 = SFZ_FH_Size(size);
    // 以高适配（安全区域，仅中间）
    CGSize size5 = SF_SCH_Size(size);
    CGSize size6 = SFZ_SCH_Size(size);
    // 以高适配（安全区域，不包括刘海）
    CGSize size7 = SF_SBH_Size(size);
    CGSize size8 = SFZ_SBH_Size(size);
    
#pragma mark CGRect
    CGRect rect = CGRectMake(10, 10, 100, 100);
    // 以宽适配
    CGRect rect1 = SF_Rect(rect);
    CGRect rect2 = SFZ_Rect(rect);
    // 以高适配（全屏）
    CGRect rect3 = SF_FH_Rect(rect);
    CGRect rect4 = SFZ_FH_Rect(rect);
    // 以高适配（安全区域，仅中间）
    CGRect rect5 = SF_SCH_Rect(rect);
    CGRect rect6 = SFZ_SCH_Rect(rect);
    // 以高适配（安全区域，不包括刘海）
    CGRect rect7 = SF_SBH_Rect(rect);
    CGRect rect8 = SFZ_SBH_Rect(rect);
    
#pragma mark UIEdgeInsets
    UIEdgeInsets edge = UIEdgeInsetsMake(0, 0, 100, 100);
    // 以宽适配
    UIEdgeInsets edge1 = SF_EdgeInsets(edge);
    UIEdgeInsets edge2 = SFZ_EdgeInsets(edge);
    // 以高适配（全屏）
    UIEdgeInsets edge3 = SF_FH_EdgeInsets(edge);
    UIEdgeInsets edge4 = SFZ_FH_EdgeInsets(edge);
    // 以高适配（安全区域，仅中间）
    UIEdgeInsets edge5 = SF_SCH_EdgeInsets(edge);
    UIEdgeInsets edge6 = SFZ_SCH_EdgeInsets(edge);
    // 以高适配（安全区域，不包括刘海）
    UIEdgeInsets edge7 = SF_SBH_EdgeInsets(edge);
    UIEdgeInsets edge8 = SFZ_SBH_EdgeInsets(edge);
    
}

@end
