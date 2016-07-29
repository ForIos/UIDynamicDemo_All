//
//  ABC_UISnapBehavior_VC.m
//  UIDynamicDemo_All
//
//  Created by lcc on 16/7/29.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "ABC_UISnapBehavior_VC.h"

@interface ABC_UISnapBehavior_VC ()

@property (weak, nonatomic) IBOutlet UIView *purperView;
/** 物理仿真器 */
@property (strong, nonatomic) UIDynamicAnimator *animator;

@end

@implementation ABC_UISnapBehavior_VC

- (void)viewDidLoad {
    [super viewDidLoad];
//    UISnapBehavior
//    
//    将物体通过动画吸附到一个点上
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//  获取触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
//  需要两个参数
//  （1）物理仿真元素
//  （2）捕捉点
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.purperView snapToPoint:point];
//  设置防震系数，数值越大，震动幅度越小  范围0~1
    snap.damping = arc4random_uniform(10)/10.0;
    
//  添加新的仿真行为，要删除以前的仿真行为
    [self.animator removeAllBehaviors];
    
//  添加仿真行为
    [self.animator addBehavior:snap];
}

-(UIDynamicAnimator *)animator
{
    if (_animator ==nil) {
        _animator = [[UIDynamicAnimator  alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

@end
