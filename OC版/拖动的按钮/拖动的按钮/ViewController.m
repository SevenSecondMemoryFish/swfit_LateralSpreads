//
//  ViewController.m
//  拖动的按钮
//
//  Created by wsj on 16/8/7.
//  Copyright © 2016年 wsj. All rights reserved.
//

#import "ViewController.h"
#import "WJView.h"
#import "UIView+VIewFrame.h"
/*屏幕的宽度*/
#define kWJScreenWidth [UIScreen mainScreen].bounds.size.width
/*屏幕的高度*/
#define kWJScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

@property(nonatomic,strong)UIButton *button;

@property(nonatomic,strong)WJView *wj_view;

@end
#warning 用于这个Demo只是为了测试，写的不是很全。效果也没有swfit版本的绚丽，抱歉了各位，但是逻辑和思维都是一样的，希望对你有帮助
#warning  我是七秒记忆鱼儿，如果在使用中出现的bug的话请联系593216709，期待你的指导，转载时请备注七秒记忆鱼儿
#warning  本工程为七秒记忆鱼儿著，转载请备注七秒记忆鱼儿。
#warning  本人简书地址为http://www.jianshu.com/users/e3402afea1f1/latest_articles
#warning  我们的swfit简书专题为http://www.jianshu.com/collection/e30d753afdee
#warning   iOS开发者交流群:446310206 小白进阶群！！期待你的加入！demo在这里！
#warning   wfit交流群为512847147 小白进阶群！！期待你的加入！demo在这里！
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.button =  [[UIButton alloc]initWithFrame:CGRectMake(kWJScreenWidth -10-50,200 , 50, 50)];
    self.button.userInteractionEnabled = YES;
    [self.button setBackgroundImage:[UIImage imageNamed:@"jiahao"] forState:0];
    self.button.backgroundColor = [UIColor redColor];
    self.button.layer.cornerRadius = 25;
    self.button.layer.masksToBounds = YES;
    [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.button addGestureRecognizer:pan];
    [self.view addSubview:self.button];
    
}
-(void)pan:(UIPanGestureRecognizer *)pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateChanged:
        {
            
            CGPoint point = [pan locationInView:self.view];
            self.button.center = point;
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (self.button.selected) {
                [self buttonClick:self.button];
                return;
            }
            if (self.button.center.x<0.5*kWJScreenWidth) {
                [UIView animateWithDuration:0.5 animations:^{
                    self.button.x = 10;
                }];
            }else{
                [UIView animateWithDuration:0.5 animations:^{
                    self.button.x = kWJScreenWidth-10-self.button.width;
                }];
            }
        }
            break;
            
        default:
            break;
    }
}
-(void)buttonClick:(UIButton *)button{
    button.selected = !button.selected;
    button.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        button.enabled = YES;
    });
    CGFloat wj_ViewX;
    CGFloat wj_ViewY;
    if (button.x == 10) {
        wj_ViewX = button.x;
        
    }else{
         wj_ViewX = button.x-100;
    }
    if (button.y < 0.4*kWJScreenHeight) {
        wj_ViewY = button.y;
    }else{
        wj_ViewY = button.y-100;
    }
    
    if (button.selected) {
        self.wj_view= [[WJView alloc]initWithFrame:CGRectMake(wj_ViewX, wj_ViewY, 150, 150)];
        self.wj_view.buttonY = button.y;
        self.wj_view.buttonX = button.x;

        self.wj_view.buttons_array = [NSArray arrayWithObjects:@"12",@"12",@"12",@"12",@"12", nil];
        [self.view addSubview:_wj_view];
        [self.view bringSubviewToFront:button];
    }else{
        self.wj_view.myBlock = ^(){};
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.wj_view removeFromSuperview];
            self.wj_view = nil;
        });
        
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
