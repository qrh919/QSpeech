//
//  UIImage+Extension.m
//  QSpeech
//
//  Created by qrh on 2018/2/28.
//  Copyright © 2018年 qrh. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)screenShoot:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
+(UIImage *)screenShootwithTabelview:(UITableView *)tableview{
    UIImage* viewImage = nil;
    UITableView *scrollView = tableview;
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, scrollView.opaque, 0.0);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        viewImage = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    return viewImage;
}
+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size {
    
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.);
    [color setFill];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)opaqueImageWithRenderColor:(UIColor *)color renderSize:(CGSize)size {
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [color setFill];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)scaleFitToSize:(CGSize)size {
    
    CGFloat scaleRate = MIN(size.width / self.size.width, size.height / self.size.height);
    return [self scaleImageToSize:size rate:scaleRate];
}

- (UIImage *)scaleFillToSize:(CGSize)size {
    
    CGFloat scaleRate = MAX(size.width / self.size.width, size.height / self.size.height);
    return [self scaleImageToSize:size rate:scaleRate];
}

- (UIImage *)scaleImageToSize:(CGSize)size rate:(CGFloat)scaleRate {
    
    UIImage *image = nil;
    CGSize renderSize = CGSizeMake(self.size.width * scaleRate, self.size.height * scaleRate);
    CGFloat startX = size.width * 0.5 - renderSize.width * 0.5;
    CGFloat startY = size.height * 0.5 - renderSize.height * 0.5;
    
    CGImageAlphaInfo info = CGImageGetAlphaInfo(self.CGImage);
    BOOL opaque = (info == kCGImageAlphaNone) || (info == kCGImageAlphaNoneSkipFirst) || (info == kCGImageAlphaNoneSkipLast);
    
    UIGraphicsBeginImageContextWithOptions(size, opaque, 0.);
    UIColor *backgroundColor = opaque ? [UIColor whiteColor] : [UIColor clearColor];
    [backgroundColor setFill];
    UIRectFillUsingBlendMode(CGRectMake(0, 0, size.width, size.height), kCGBlendModeNormal);
    
    [self drawInRect:CGRectMake(startX, startY, renderSize.width, renderSize.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
- (UIImage*)scaleWithMaxWidth:(CGFloat)width
{
    CGFloat imageWidth = self.size.width;
    if (imageWidth < width) {
        return self;
    }
    CGFloat imageHeight = self.size.height;
    CGFloat scale = width / imageWidth;
    imageHeight = imageHeight * scale;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, imageHeight));
    [self drawInRect:CGRectMake(0, 0, width, imageHeight)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
-(UIImage *)trimImageWithSize:(CGSize)size{
    
    //imageView的宽高比
    CGFloat imageViewWidthHeightRatio =size.width/size.height;
    //屏幕分辨率
    CGFloat imageScale = [[UIScreen mainScreen] scale];
    //    CGFloat imageScale = 1;
    
    CGFloat imageWith = self.size.width*imageScale;
    
    CGFloat imageHeight =self.size.height*imageScale;
    
    //image的宽高比
    CGFloat imageWidthHeightRatio =imageWith/imageHeight;
    
    CGImageRef imageRef = nil;
    
    CGRect rect;
    
    if (imageWidthHeightRatio>imageViewWidthHeightRatio) {
        
        rect = CGRectMake((imageWith-imageHeight*imageViewWidthHeightRatio)/2, 0, imageHeight*imageViewWidthHeightRatio, imageHeight);
        
    }else if (imageWidthHeightRatio<imageViewWidthHeightRatio) {
        
        rect = CGRectMake(0, (imageHeight-imageWith/imageViewWidthHeightRatio)/2, imageWith, imageWith/imageViewWidthHeightRatio);
        
    }else {
        rect = CGRectMake(0, 0, imageWith, imageHeight);
    }
    
    imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *res = [UIImage imageWithCGImage:imageRef scale:imageScale orientation:UIImageOrientationUp];
    
    /**
     一定要，千万要release，否则等着内存泄露吧，稍微高清点的图一张图就是几M内存，很快App就挂了
     */
    CGImageRelease(imageRef);
    
    return res;
}
+ (UIImage *)imageWithCornerRadius:(float)radius fillColor:(UIColor *)fillColor StrokeColor:(UIColor *)strokeColor {
    CGSize renderSize = CGSizeMake(10, 10);
    UIGraphicsBeginImageContextWithOptions(renderSize, NO, 0.);
    CGContextRef drawCtx = UIGraphicsGetCurrentContext();
    CGPathRef borderPath = CGPathCreateWithRoundedRect((CGRect){CGPointZero,renderSize}, radius, radius, NULL);
    CGContextAddPath(drawCtx, borderPath);
    if (strokeColor) {
        [strokeColor setStroke];
        CGContextDrawPath(drawCtx, kCGPathStroke);
    }
    if (fillColor) {
        [fillColor setFill];
        CGContextDrawPath(drawCtx, kCGPathFill);
    }
    UIImage *resImage = [UIGraphicsGetImageFromCurrentImageContext() resizableImageWithCapInsets:UIEdgeInsetsMake(radius/2., radius/2., radius/2., radius/2.)];
    UIGraphicsEndImageContext();
    CGPathRelease(borderPath);
    
    return resImage;
}

+ (UIImage *)imageWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)radius fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor {
    
    CGRect circleRect = CGRectMake(lineWidth , lineWidth, size.width-lineWidth*2, size.height-lineWidth*2);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.);
    CGContextRef drawCtx = UIGraphicsGetCurrentContext();
    CGPathRef renderPath = CGPathCreateWithRoundedRect(circleRect, radius, radius, NULL);
    CGContextAddPath(drawCtx, renderPath);
    
    if (strokeColor && fillColor) {
        [fillColor setFill];
        [strokeColor setStroke];
        
        CGContextDrawPath(drawCtx, kCGPathFillStroke);
    } else {
        if (fillColor) {
            [fillColor setFill];
            CGContextDrawPath(drawCtx, kCGPathFill);
        } else if (strokeColor) {
            [strokeColor setStroke];
            CGContextDrawPath(drawCtx, kCGPathStroke);
        }
    }
    
    UIImage *resImage = [UIGraphicsGetImageFromCurrentImageContext() resizableImageWithCapInsets:UIEdgeInsetsMake(lineWidth+radius, lineWidth+radius, lineWidth+radius, lineWidth+radius)];
    UIGraphicsEndImageContext();
    CGPathRelease(renderPath);
    
    return resImage;
}

+ (UIImage*)imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage* theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)imageBcakgroundColor:(UIColor *)color addText:(NSString *)text {
    
    CGSize size = CGSizeMake(16, 16);
    UIGraphicsBeginImageContext(size);
    //    UIImage *bgImage = [UIImage imageNamed:@"df_icon_orange_cube"];
    UIImage *bgImage = [self imageWithRoundedCornerRadius:3 renderColor:color renderSize:size borderWidth:0 borderCorlor:[UIColor clearColor]];
    [bgImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:12],
                                  NSForegroundColorAttributeName : [UIColor blackColor],
                                  NSParagraphStyleAttributeName : paragraph};
    [text drawInRect:CGRectMake(0, 0, size.width, size.height) withAttributes:attributes];
    UIImage* resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImg;
}

+ (UIImage*)imageWithRoundedCornerRadius:(CGFloat)radius
                             renderColor:(UIColor *)color
                              renderSize:(CGSize)size
                             borderWidth:(CGFloat)borderWidth
                            borderCorlor:(UIColor*)borderColor {
    
    CGFloat halfBorderWidth = borderWidth / 2.0;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGFloat width = size.width, height = size.height;
    CGContextMoveToPoint(context, width - halfBorderWidth, radius + halfBorderWidth); // 准备开始移动坐标
    CGContextAddArcToPoint(context, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius);
    CGContextAddArcToPoint(context, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius); // 左下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius); // 左上角
    CGContextAddArcToPoint(context, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius);
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
+ (UIImage *)navigationImageName:(NSString *)imageName {
    return  [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
+ (UIImage *)getImageFromURL:(NSString *)fileURL
{
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}

@end
