//
//  QTranstionAnimation.m
//  QSpeech
//
//  Created by qrh on 2018/1/15.
//  Copyright © 2018年 qrh. All rights reserved.
//

#import "QTranstionAnimation.h"
#import "QPresentationController.h"

static QTranstionAnimation *transtion = nil;

@interface QTranstionAnimation()
@property (nonatomic, assign) BOOL isPresnted;
@end;

@implementation QTranstionAnimation
//构造单例
+(instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        transtion = [[super allocWithZone:nil] init];
    });
    return transtion;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    return [QTranstionAnimation shareInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [QTranstionAnimation shareInstance];
}

#pragma mark - UIViewControllerContextTransitioning
- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
        
    if (self.isPresnted == YES) {
        //1.取出view
        UIView *presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];
        //2.放入containerView
        [[transitionContext containerView] addSubview:presentedView];
        //3.自定义添加动画
        if(self.animatType == QTranstionAnimationType_FromTop){
            
            presentedView.frame = CGRectMake(0, -kScreenH, kScreenW, kScreenH);
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                presentedView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
            }completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
            
        }else if(self.animatType == QTranstionAnimationType_FadeInOut){
            
            presentedView.alpha = 0;
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                presentedView.alpha = 1.0;
            }completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        }
  
    } else {
        //1.取出view
        UIView *dismissedView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        //2.放入containerView
        [[transitionContext containerView]addSubview:dismissedView];
        //3.自定义添加动画
        if(self.animatType == QTranstionAnimationType_FromTop){
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                dismissedView.frame =CGRectMake(0, -kScreenH, kScreenW, kScreenH);
            }completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
            
        }else if (self.animatType == QTranstionAnimationType_FadeInOut){
            
            dismissedView.alpha = 1;
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                dismissedView.alpha = 0;
            }completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        }
    }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}

#pragma mark - UIViewControllerTransitioningDelegate
//设置负责进场的对象
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresnted = YES;
    return self;
}
//设置负责出场的对象
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresnted = NO;
    return self;
}
//一下两个方法负责交互处理
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator;
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator;

//该方法为对目标控制器的处理
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source{
    
    QPresentationController *persentVC = [[QPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    persentVC.contentFrame = CGRectMake((kScreenW-300)/2, (kScreenH-400)/2, 300, 400);
    return persentVC;
}
@end
