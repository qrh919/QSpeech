//
//  QPresentationController.m
//  QSpeech
//
//  Created by qrh on 2018/1/15.
//  Copyright © 2018年 qrh. All rights reserved.
//  

#import "QPresentationController.h"

@interface QPresentationController()
@property (nonatomic, strong) UIView *coverView;//蒙板
@end

@implementation QPresentationController

-(void)containerViewWillLayoutSubviews{
    [super containerViewWillLayoutSubviews];
    
    self.presentedView.frame = self.contentFrame;
    [self.containerView insertSubview:self.coverView atIndex:0];
    
}

-(void)didMissAction{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

-(UIView *)coverView{
    if(!_coverView){
        _coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _coverView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didMissAction)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

@end
