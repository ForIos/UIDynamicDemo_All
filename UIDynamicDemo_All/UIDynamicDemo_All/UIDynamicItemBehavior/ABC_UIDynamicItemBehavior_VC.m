//
//  ABC_UIDynamicItemBehavior_VC.m
//  UIDynamicDemo_All
//
//  Created by lcc on 16/7/28.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "ABC_UIDynamicItemBehavior_VC.h"

@interface ABC_UIDynamicItemBehavior_VC ()
@property (strong, nonatomic) UIDynamicAnimator *animator;
@end

@implementation ABC_UIDynamicItemBehavior_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//   构造动画
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
//   gravity 重力
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.topView,self.bottomView]];
    [self.animator addBehavior:gravity];
    
//    collision 碰撞
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]
                                      initWithItems:@[self.topView, self.bottomView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
    
//   指派不同特性值  弹性bounce 动力元素
    UIDynamicItemBehavior *moreElasticItem = [[UIDynamicItemBehavior alloc]
                                              initWithItems:@[self.bottomView]];
    moreElasticItem.elasticity = 1.0f;
    
    UIDynamicItemBehavior *lessElasticItem = [[UIDynamicItemBehavior alloc]
                                              initWithItems:@[self.topView]];
    lessElasticItem.elasticity = 0.5f;
    [self.animator addBehavior:moreElasticItem];
    [self.animator addBehavior:lessElasticItem];
}



@end
