//
//  ABC_UIPushBehavior_VC.m
//  UIDynamicDemo_All
//
//  Created by lcc on 16/7/28.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "ABC_UIPushBehavior_VC.h"

    // 设置一个速度阀值
static const CGFloat ThrowingThreshold = 1000;
    // 它将对抛掷 view 的快慢产生影响
static const CGFloat ThrowingVelocityPadding = 35;

@interface ABC_UIPushBehavior_VC ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIView *redSquare;
@property (weak, nonatomic) IBOutlet UIView *blueSquare;

@property (nonatomic, assign) CGRect originalBounds;
@property (nonatomic, assign) CGPoint originalCenter;

//仿真行为
@property (nonatomic) UIDynamicAnimator *animator;
//附着
@property (nonatomic) UIAttachmentBehavior *attachmentBehavior;
//推动行为
@property (nonatomic) UIPushBehavior *pushBehavior;
// 动力元素
// allowsRotation是否允许旋转
// resistance 抗阻力
// friction
@property (nonatomic) UIDynamicItemBehavior *itemBehavior;
@end

@implementation ABC_UIPushBehavior_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.originalBounds = self.image.bounds;
    self.originalCenter = self.image.center;
}


- (IBAction) handleAttachmentGesture:(UIPanGestureRecognizer*)gesture
{
    CGPoint location = [gesture locationInView:self.view];
    CGPoint boxLocation = [gesture locationInView:self.image];
    
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
//              1
            [self.animator removeAllBehaviors];
//              2
            UIOffset centerOffset = UIOffsetMake(boxLocation.x - CGRectGetMidX(self.image.bounds),
                                                     boxLocation.y - CGRectGetMidY(self.image.bounds));
            self.attachmentBehavior  = [[UIAttachmentBehavior alloc] initWithItem:self.image
                                                                 offsetFromCenter:centerOffset
                                                                 attachedToAnchor:location];
            self.redSquare.center = self.attachmentBehavior.anchorPoint;
            self.blueSquare.center = location;
                // 4
            [self.animator addBehavior:self.attachmentBehavior];
            }
            break;
        case UIGestureRecognizerStateEnded:{
            [self.animator removeBehavior:self.attachmentBehavior];
            
//           1.获取拖拽view的速度
            CGPoint veloctiy = [gesture velocityInView:self.view];
//           2.计算当前初线速度
            CGFloat magnitude = sqrtf((veloctiy.x * veloctiy.x) + (veloctiy.y * veloctiy.y));
            
/************************************此处加了一个力量*************************************/
//           设定一个速度限制，超过这个速度创建 UIPushBehavior
            if (magnitude>ThrowingThreshold) {
//               两种mode形式
//               （1）UIPushBehaviorModeContinuous （持续力）
//               （2）UIPushBehaviorModeInstantaneous 一次性力
                
                UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.image] mode:UIPushBehaviorModeInstantaneous];
//              vector  矢量
                pushBehavior.pushDirection = CGVectorMake((veloctiy.x / 10) , (veloctiy.y / 10));
//              magnitude 的属性控制 push 的快慢 必须慢慢试才能找出最合适的值
                pushBehavior.magnitude = magnitude / ThrowingVelocityPadding;
                
                self.pushBehavior = pushBehavior;
                [self.animator addBehavior:self.pushBehavior];
                
//              3
               
                
/************************************力量之后的  动力元素(推出很远很远的地方) *************************************/
//            allowsRotation :是否允许旋转
//            resistance: 抗阻力 0~CGFLOAT_MAX ，阻碍原有所加注的行为（如本来是重力自由落体行为，则阻碍其下落，阻碍程度根据其值来决定）
//            friction: 磨擦力 0.0~1.0 在碰撞行为里，碰撞对象的边缘产生
//            elasticity:弹跳性 0.0~1.0
//            density:密度 0~1

                NSInteger angle = arc4random_uniform(20)-10;
                self.itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.image]];
                self.itemBehavior.friction = 0.2;
                self.itemBehavior.allowsRotation = YES;
                [self.itemBehavior addAngularVelocity:angle forItem:self.image];
                [self.animator addBehavior:self.itemBehavior];
/************************************恢复为原样*************************************/
                [self performSelector:@selector(resetDemo) withObject:nil afterDelay:0.4];
            }else{
                [self resetDemo];
            }
        }
        default:
            break;
    }
    [self.attachmentBehavior setAnchorPoint:[gesture locationInView:self.view]];
    self.redSquare.center = self.attachmentBehavior.anchorPoint;
}

- (void)resetDemo
{
    [self.animator removeAllBehaviors];
    
    [UIView animateWithDuration:0.45 animations:^{
        self.image.bounds = self.originalBounds;
        self.image.center = self.originalCenter;
        self.image.transform = CGAffineTransformIdentity;
    }];
}


@end
