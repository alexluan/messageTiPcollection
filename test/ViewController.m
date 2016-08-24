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
    
    __block dispatch_source_t _timer;
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
    
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(10, queue, ^(size_t index) {
        NSLog(@"%zu",index);
    });
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
    //倒计时时间
    __block NSInteger timeOut = 5;
    
    if (!_timer) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        //每秒执行一次
        /**
         start参数控制计时器第一次触发的时刻。参数类型是 dispatch_time_t，这是一个opaque类型，我们不能直接操作它。我们得需要 dispatch_time 和  dispatch_walltime 函数来创建它们。另外，常量  DISPATCH_TIME_NOW 和 DISPATCH_TIME_FOREVER 通常很有用。
         interval参数没什么好解释的。
         leeway参数比较有意思。这个参数告诉系统我们需要计时器触发的精准程度。所有的计时器都不会保证100%精准，这个参数用来告诉系统你希望系统保证精准的努力程度。如果你希望一个计时器没五秒触发一次，并且越准越好，那么你传递0为参数。另外，如果是一个周期性任务，比如检查email，那么你会希望每十分钟检查一次，但是不用那么精准。所以你可以传入60ull * NSEC_PER_SEC，告诉系统60秒的误差是可接受的。
         */
        //    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
        dispatch_source_set_timer(_timer, dispatch_walltime(DISPATCH_TIME_NOW, 5*NSEC_PER_SEC) , 1.0* NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [BLStatusMessageInfo bl_showStateMessageInof:@"ASDFASDF"];
            });
            dispatch_suspend(_timer);
        });

    }
        dispatch_resume(_timer);
   

   
}
@end
