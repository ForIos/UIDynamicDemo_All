//
//  GravityAndCollision_VC.m
//  UIDynamicDemo_All
//
//  Created by lcc on 16/7/28.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "Gravity_VC.h"

@interface Gravity_VC ()
@property (nonatomic,strong) UIDynamicAnimator *animator;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@end

@implementation Gravity_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.blueView.transform = CGAffineTransformMakeRotation(M_PI_4);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//   创建重力行为
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] init];
    [gravityBehavior addItem:self.blueView];
    
    gravityBehavior.magnitude = 1;
    [self.animator addBehavior:gravityBehavior];
}

-(UIDynamicAnimator *)animator
{
    if (_animator == nil) {
        _animator = [[UIDynamicAnimator alloc]init];
    }
    return _animator;
}

@end
