//
//  PromoMessage.m
//  test
//
//  Created by 栾有数 on 16/8/24.
//  Copyright © 2016年 栾有数. All rights reserved.
//

#import "BLStatusMessageInfo.h"

#define BLFont [UIFont systemFontOfSize:12]

/** 状态栏显示时间 */
static CGFloat const BLStateShowDuration = 2.5;

/** 状态栏消失时间 */
static CGFloat const BLStateDismissDuration = 0.3;

/** 状态栏高度 */
static CGFloat const BLStateHeight = 20;

static UIWindow *windowMessage;

/** 全局的文字颜色 */
static UIColor *titleColor_;

/** 全局的背景颜色 */
static UIColor *backGroudColor_;

/** 全局的文字颜色 */
static UIColor *titleColor_;

@implementation BLStatusMessageInfo



/** 状态栏提示框 */
+ (void)showWindow
{
    
    if (backGroudColor_ == nil) {
        backGroudColor_ = [UIColor blackColor];
    }
    if (titleColor_) {
        titleColor_ = [UIColor whiteColor];
    }
    __block CGRect frame = CGRectMake(0, -BLStateHeight, [UIScreen mainScreen].bounds.size.width, BLStateHeight);
    
    // 显示前先隐藏
    windowMessage.hidden = YES;
    windowMessage = [[UIWindow alloc] init];
    windowMessage.frame = frame;
  
    windowMessage.backgroundColor = backGroudColor_;
    windowMessage.windowLevel = UIWindowLevelAlert;
    windowMessage.hidden = NO;
    
    frame.origin.y = 0;
    
    [UIView animateWithDuration:BLStateShowDuration animations:^{
        
        windowMessage.frame = frame;
        
    }completion:^(BOOL finished) {
        frame.origin.y = -BLStateHeight;
        [UIView animateWithDuration:BLStateDismissDuration animations:^{
            windowMessage.frame = frame;
        }completion:^(BOOL finished) {
            windowMessage = nil;
        }];
    }];
}

+ (void)bl_showStateMessageInof:(NSString *)title{
        // 添加一个button，显示文字及配图
    [self showWindow];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = BLFont;
        if (titleColor_) {
            [button setTitleColor:titleColor_ forState:UIControlStateNormal];
        } else {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    
        // 如果有配图，则显示
            [button setImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        button.frame = windowMessage.bounds;
        [windowMessage addSubview:button];

}

/** 修改背景颜色 */
+ (void)bl_setStateMessageBackGroudColor:(UIColor *)color{
    backGroudColor_ = color;
}

/** 修改字体颜色 */
+ (void)xcm_setStateMessageTitleColor:(UIColor *)color{
    titleColor_ = color;
}
@end
