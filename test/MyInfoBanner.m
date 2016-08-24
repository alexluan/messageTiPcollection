//
//  MyInfoBanner.m
//  test
//
//  Created by 栾有数 on 16/8/24.
//  Copyright © 2016年 栾有数. All rights reserved.
//

#import "MyInfoBanner.h"
#import "POP.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Masonry/Masonry.h>
#import "AFMInfoBanner.h"

@interface MyInfoBanner()

@property (strong, nonatomic) UILabel * labelInfo;

@end

@implementation MyInfoBanner

- (instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.labelInfo];
        [self.labelInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

+ (void)show:(NSString *)tet{
    MyInfoBanner * banner = [MyInfoBanner new];
    banner.labelInfo.text = tet;
    
    UIWindow * window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:banner];
    [banner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(window.mas_top);
        make.leading.trailing.equalTo(window);
        make.height.offset(30);
    }];
    
    [UIView animateWithDuration:3 animations:^{
        banner.transform = CGAffineTransformMakeTranslation(0, 30);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:3 animations:^{
            banner.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [banner removeFromSuperview];
        }];
    }];
    
    

    
}

@end
