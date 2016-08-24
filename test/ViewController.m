//
//  ViewController.m
//  test
//
//  Created by 栾有数 on 16/8/24.
//  Copyright © 2016年 栾有数. All rights reserved.
//

#import "ViewController.h"
#import "POP.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Masonry/Masonry.h>
#import "AFMInfoBanner.h"
#import "MyInfoBanner.h"
#import "BLStatusMessageInfo.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *minImageView;

@property (strong, nonatomic) UIImageView * mainImageView;
- (IBAction)btnAction:(id)sender;


@end

@implementation ViewController{
    UIView *background;
}
static UIWindow *win;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //允许用户交互
    _minImageView.userInteractionEnabled = YES;
    //添加点击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [_minImageView addGestureRecognizer:tapGesture];
    
   
}

- (void)viewDidAppear:(BOOL)animated{
    win = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 88)];
    win.hidden = NO;
    win.backgroundColor = [UIColor redColor];

}
//点击图片后的方法(即图片的放大全屏效果)
- (void) tapAction{
    //创建一个黑色背景
    //初始化一个用来当做背景的View。我这里为了省时间计算，宽高直接用的5s的尺寸
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 600)];
    CGRect rect = [self.view convertRect:self.minImageView.frame toView:self.view ];
    bgView.frame = rect;
    background = bgView;
    [bgView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:bgView];
    {
        UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg1.jpeg"]];
        [bgView addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(bgView);
        }];
    }
    {
        UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
        [bgView addGestureRecognizer:tapGesture1];
    }
   
    
    POPBasicAnimation *anBasic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    anBasic.fromValue = [NSValue valueWithCGRect:rect];
    anBasic.toValue = [NSValue valueWithCGRect:self.view.frame];
//    anBasic.beginTime = CACurrentMediaTime() + 1.0f;
      anBasic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    anBasic.repeatCount = 3;
    anBasic.repeatForever = YES;
    anBasic.delegate = self;
    [bgView pop_addAnimation:anBasic forKey:@"bgi"];
    
}
-(void)closeView{
    [background removeFromSuperview];
}
//放大过程中出现的缓慢动画
- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction:(id)sender {
//    [AFMInfoBanner showAndHideWithText:@"asdfasdf" style:AFMInfoBannerStyleInfo];
//    [MyInfoBanner show:@"asdfasdf"];
    [BLStatusMessageInfo bl_showStateMessageInof:@"ASDFASDF"];
}
@end
