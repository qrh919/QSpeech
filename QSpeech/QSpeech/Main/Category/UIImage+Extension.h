//
//  UIImage+Extension.h
//  QSpeech
//
//  Created by qrh on 2018/2/28.
//  Copyright © 2018年 qrh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *)screenShoot:(UIView *)view;
+ (UIImage *)screenShootwithTabelview:(UITableView *)tableview;

- (UIImage *)scaleFitToSize:(CGSize)size;

- (UIImage *)scaleFillToSize:(CGSize)size;

- (UIImage*)scaleWithMaxWidth:(CGFloat)width;

- (UIImage *)trimImageWithSize:(CGSize)size;

+ (UIImage*)imageWithColor:(UIColor*)color;

+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size;

+ (UIImage *)opaqueImageWithRenderColor:(UIColor *)color renderSize:(CGSize)size;

+ (UIImage *)imageWithCornerRadius:(float)radius fillColor:(UIColor *)fillColor StrokeColor:(UIColor *)strokeColor;

+ (UIImage *)imageWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)radius fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor;

+ (UIImage *)imageBcakgroundColor:(UIColor *)color addText:(NSString *)text;

+ (UIImage *)navigationImageName:(NSString *)imageName;

+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha image:(UIImage*)image;

+ (UIImage *)getImageFromURL:(NSString *)fileURL;

@end
