//
//  UILabel+Extension.m
//  QSpeech
//
//  Created by qrh on 2018/1/10.
//  Copyright © 2018年 qrh. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (instancetype)labelConfigure:(void (^)(UILabel* label))configureBlock
{
    UILabel* label = [[UILabel alloc] init];
    label.numberOfLines = 1;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14];
    if (configureBlock) {
        configureBlock(label);
    }
    return label;
}

@end
