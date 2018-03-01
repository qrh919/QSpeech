//
//  UILabel+Extension.h
//  QSpeech
//
//  Created by qrh on 2018/1/10.
//  Copyright © 2018年 qrh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

+ (instancetype)labelConfigure:(void (^)(UILabel* label))configureBlock;

@end
