//
//  QMainCollectionCell.m
//  QSpeech
//
//  Created by qrh on 2018/1/10.
//  Copyright © 2018年 qrh. All rights reserved.
//

#import "QMainCollectionCell.h"

@interface QMainCollectionCell()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleL;
@end

@implementation QMainCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;//阴影颜色
        self.layer.shadowOffset = CGSizeMake(2, 2);//偏移距离
        self.layer.shadowOpacity = 0.5;//不透明度
        self.layer.shadowRadius = 4.0;//半径
        [self createSubViews];
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleL.text = title;
}

-(void)createSubViews{
    [self addSubview:self.bgView];
    [_bgView addSubview:self.titleL];
    WS(wSelf);
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(wSelf.contentView);
        make.size.equalTo(wSelf.contentView);
    }];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(wSelf.bgView);
    }];
}

-(UIView *)bgView{
    if(!_bgView){
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
        _bgView.layer.cornerRadius = self.frame.size.width/2;
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.borderColor = [UIColor orangeColor].CGColor;
        _bgView.layer.borderWidth = 5;
    }
    return _bgView;
}
-(UILabel *)titleL{
    if(!_titleL){
        _titleL = [UILabel labelConfigure:^(UILabel *label) {
            label.font = [UIFont boldSystemFontOfSize:40];
            label.textAlignment = NSTextAlignmentCenter;
        }];
    }
    return _titleL;
}
@end
/**************** Header *****************/
@interface QMainCollectionHeader()
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleL;
@end

@implementation QMainCollectionHeader

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    // 设置线条的样式
    CGContextSetLineCap(context, kCGLineCapRound);
    // 绘制线的宽度
    CGContextSetLineWidth(context, 0.5);
    // 线的颜色
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    // 开始绘制
    CGContextBeginPath(context);
    // 设置虚线绘制起点
    CGContextMoveToPoint(context, 0, rect.size.height-1);
    // lengths的值｛4,2｝表示先绘制4个点，再跳过2个点，如此反复
    CGFloat lengths[] = {4,2};
    // 虚线的起始点
    CGContextSetLineDash(context, 0, lengths,2);
    // 绘制虚线的终点
    CGContextAddLineToPoint(context, rect.size.width,rect.size.height-1);
    // 绘制
    CGContextDrawPath(context, kCGPathStroke);
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews{
    [self addSubview:self.imageV];
    [self addSubview:self.titleL];
    
    WS(wSelf);
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf).offset(22);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.equalTo(wSelf);
    }];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.imageV.mas_right).offset(5);
        make.right.equalTo(wSelf);
        make.centerY.equalTo(wSelf.imageV);
        make.height.equalTo(@25);
    }];
}

-(UIImageView *)imageV{
    if(!_imageV){
        _imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageV;
}

-(UILabel *)titleL{
    if(!_titleL){
        _titleL = [UILabel labelConfigure:^(UILabel *label) {
            label.font = [UIFont systemFontOfSize:16];
            label.text = @"小朋友，点一个试试吧";
        }];
    }
    return _titleL;
}
@end
