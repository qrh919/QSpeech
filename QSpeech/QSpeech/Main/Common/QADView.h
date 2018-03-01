//
//  QADView.h
//  QSpeech
//
//  Created by qrh on 2018/2/28.
//  Copyright © 2018年 qrh. All rights reserved.
//  广告视图

#import <UIKit/UIKit.h>

@interface QADView : UIView

@property (nonatomic, copy) void (^jumpOverBlock) (void);

+ (instancetype)sharedInstance;

- (instancetype)init __attribute__((unavailable("init not available, call sharedInstance instead")));

- (void)timeStart;

@end
