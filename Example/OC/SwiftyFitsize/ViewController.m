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
    [SwiftyFitsize referenceWithWidth:414 iPadFitMultiple:0.6];
    
    UIFont *font = [UIFont systemFontOfSize:14];
    UIFont *font1 = font.sf;
    UIFont *font2 = font.sfz;
    UIFont *font3 = SF_Font(font);
    UIFont *font4 = SFZ_Font(font);
    
    CGFloat num1 = SF_Float(14);
    CGPoint point1 = SF_Point(CGPointMake(10, 10));
    CGSize size1 = SF_Size(CGSizeMake(100, 100));
    CGRect rect1 = SF_Rect(CGRectMake(10, 10, 100, 100));
    UIEdgeInsets edge1 = SF_EdgeInsets(UIEdgeInsetsMake(0, 0, 100, 100));
    
    CGFloat num2 = SFZ_Float(14);
    CGPoint point2 = SFZ_Point(CGPointMake(10, 10));
    CGSize size2 = SFZ_Size(CGSizeMake(100, 100));
    CGRect rect2 = SFZ_Rect(CGRectMake(10, 10, 100, 100));
    UIEdgeInsets edge2 = SFZ_EdgeInsets(UIEdgeInsetsMake(0, 0, 100, 100));
}

@end
