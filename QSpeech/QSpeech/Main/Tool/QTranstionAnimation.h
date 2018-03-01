//
//  QTranstionAnimation.h
//  QSpeech
//
//  Created by qrh on 2018/1/15.
//  Copyright © 2018年 qrh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, QTranstionAnimationType) {
    
    QTranstionAnimationType_FromTop,   //上进上出
    QTranstionAnimationType_FadeInOut   //淡入淡出
    
};


@interface QTranstionAnimation : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

//初始化
+(instancetype)shareInstance;

/**
 动画类型
 */
@property (nonatomic, assign) QTranstionAnimationType animatType;

@end
