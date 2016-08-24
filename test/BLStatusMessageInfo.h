//
//  PromoMessage.h
//  test
//
//  Created by 栾有数 on 16/8/24.
//  Copyright © 2016年 栾有数. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BLStatusMessageInfo : NSObject

+ (void)bl_showStateMessageInof:(NSString *)title;

/** 修改背景颜色 */
+ (void)bl_setStateMessageBackGroudColor:(UIColor *)color;

/** 修改字体颜色 */
+ (void)xcm_setStateMessageTitleColor:(UIColor *)color;
@end
