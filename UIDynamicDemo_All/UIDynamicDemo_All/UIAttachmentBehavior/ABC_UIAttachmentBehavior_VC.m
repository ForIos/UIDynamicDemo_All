//
//  ABC_UIAttachmentBehavior_VC.m
//  UIDynamicDemo_All
//
//  Created by lcc on 16/7/28.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "ABC_UIAttachmentBehavior_VC.h"

@interface ABC_UIAttachmentBehavior_VC ()

@property (weak, nonatomic) IBOutlet UIView *lightBlueView;

/*仿真器*/
@property (nonatomic,strong)UIDynamicAnimator *animator;

@property (nonatomic,strong)UIAttachmentBehavior *attach;


@end

@implementation ABC_UIAttachmentBehavior_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view ];
}

/**
 *  // 该锚点关联物理仿真元素附着的点，在这个例子中，就是你的手指所触摸的那个点，
   （1）lightBlueView 是围绕这个点在运动的。
         CGPoint anchorPoint;
    （2） 反弹距离
         CGFloat length;
    （3）衰减，经测试，这个值越大，可以减震
         CGFloat damping;
    （4）该值越大，物理仿真元素运动越剧烈
        CGFloat frequency
    （5）反抗旋转的程度
        GFloat frictionTorque
 */
- (IBAction)handleAttachmentGesture:(UIPanGestureRecognizer *)pan
{
//    在手势开始时添加 物理仿真行为
    if (pan.state == UIGestureRecognizerStateBegan) {
//      首先要移除物理仿真行为
        [self.animator removeAllBehaviors];
        
//      获取手势在view 容器中的位置
        CGPoint location= [pan locationInView:self.view];
//      获得手势在lightBlueview中的位置
        CGPoint boxLocation = [pan locationInView:self.lightBlueView];
        
// 以 lightBlueView 为参考坐标系，计算触摸点到 lightBlueView 中点的偏移量
        UIOffset offset = UIOffsetMake(boxLocation.x -CGRectGetMidX(self.lightBlueView.bounds) , boxLocation.y - CGRectGetMidY(self.lightBlueView.bounds));
        
//       创建物理仿真行为
        self.attach = [[UIAttachmentBehavior alloc] initWithItem:self.lightBlueView offsetFromCenter:offset attachedToAnchor:location];
//        self.attach.damping = 10000;
//        self.attach.frequency = 10000;
//        self.attach.length = 100;
//        self.attach.frictionTorque = 100;
        [self.animator addBehavior:self.attach];
    }
    [self.attach setAnchorPoint:[pan locationInView:self.view]];
}

@end
