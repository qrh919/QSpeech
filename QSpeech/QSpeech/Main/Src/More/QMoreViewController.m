//
//  QMoreViewController.m
//  QSpeech
//
//  Created by qrh on 2018/1/10.
//  Copyright © 2018年 qrh. All rights reserved.
//

#import "QMoreViewController.h"
#import "QTranstionAnimation.h"

@interface QMoreViewController ()<POPAnimationDelegate>
@property (nonatomic, strong) UIView *ballView;
@end

@implementation QMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"其他";
    [self initConfigure];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initConfigure{
    _ballView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    _ballView.center = self.view.center;
    _ballView.layer.masksToBounds = YES;
    _ballView.layer.cornerRadius = _ballView.bounds.size.width/2;
    _ballView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_ballView];
    
    //拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(PanGesture:)];
    [_ballView addGestureRecognizer:pan];
    
    //点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [_ballView addGestureRecognizer:tap];
}

-(void)tapGesture:(UITapGestureRecognizer *)tap{
    QTranstionAnimation *animation = [QTranstionAnimation shareInstance];
    self.transitioningDelegate = animation;
    [self dismissViewControllerAnimated:YES completion:nil];
}

//拖拽手势
- (void)PanGesture:(UIPanGestureRecognizer*)pan{
    //在拖动过程中
    //取出偏移量
    CGPoint offset = [pan translationInView:self.view];
    //让baseView平移
    _ballView.transform = CGAffineTransformTranslate(_ballView.transform, offset.x, offset.y);
    //平移完之后将偏移量重新置为0
    //这很重要，要记住
    [pan setTranslation:CGPointZero inView:self.view];
    
    
    //当拖动手势结束的时候，开始动画
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        POPDecayAnimation *decayAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
        CGPoint velocity = [pan velocityInView:self.view];
        decayAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        [_ballView.layer pop_addAnimation:decayAnimation forKey:@"layerPositionAnimation"];
        
        decayAnimation.delegate = self;
        
    }
    
}

#pragma mark - POPAnimationDelegate
///在小球弹动的过程中判断是否碰壁
- (void)pop_animationDidApply:(POPDecayAnimation *)anim
{
    BOOL baseViewInsideOfSuperView = CGRectContainsRect(self.view.frame, self.ballView.frame);
    if (!baseViewInsideOfSuperView) {
        
        CGPoint currentVelocity = [anim.velocity CGPointValue];
        CGPoint velocity = CGPointMake(currentVelocity.x, -currentVelocity.y);
        POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        positionAnimation.toValue = [NSValue valueWithCGPoint:self.view.center];
        [self.ballView.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    }
    
}



@end
