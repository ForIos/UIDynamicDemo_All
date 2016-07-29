//
//  Gravity_VC.m
//  UIDynamicDemo_All
//
//  Created by lcc on 16/7/28.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "GravityAndCollision_VC.h"

@interface GravityAndCollision_VC ()
@property (nonatomic,strong) UIDynamicAnimator *animator;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *orangeView;
@end

@implementation GravityAndCollision_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.blueView.transform =     CGAffineTransformMakeRotation(M_PI_4);
    self.segmented.transform = CGAffineTransformMakeRotation(-M_PI / 8);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//   创建重力行为
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] init];
    [gravityBehavior addItem:self.blueView];
    [gravityBehavior addItem:self.orangeView];
    
//   加速度
    gravityBehavior.magnitude = 1;
    
//   创建碰撞行为
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] init];
//   碰撞类型为元素和边界
    collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    
    CGFloat Y = self.view.frame.size.height - CGRectGetHeight(self.redView.frame);
    CGFloat X = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
        //设置红色的View为底边界,左边框跟右边框作为边界
    [collisionBehavior addBoundaryWithIdentifier:@"collision1" fromPoint:CGPointMake(0,Y) toPoint:CGPointMake(X, Y)];
    [collisionBehavior addBoundaryWithIdentifier:@"collision2" fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(0, height)];
    [collisionBehavior addBoundaryWithIdentifier:@"collision3" fromPoint:CGPointMake(X,0) toPoint:CGPointMake(X, height)];

    [collisionBehavior addItem:self.blueView];
    [collisionBehavior addItem:self.segmented];
    [collisionBehavior addItem:self.orangeView];
    [self.animator addBehavior:collisionBehavior];
    [self.animator addBehavior:gravityBehavior];
}



- (UIDynamicAnimator *)animator{
    if (_animator == nil) {
        _animator = [[UIDynamicAnimator alloc]init];
    }
    return _animator;
}

@end
