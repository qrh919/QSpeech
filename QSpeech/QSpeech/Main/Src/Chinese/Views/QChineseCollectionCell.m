//
//  QChineseCollectionCell.m
//  QSpeech
//
//  Created by qrh on 2018/1/11.
//  Copyright © 2018年 qrh. All rights reserved.
//

#import "QChineseCollectionCell.h"

@interface QChineseCollectionCell()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleL;
@end

@implementation QChineseCollectionCell
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
        _bgView.layer.cornerRadius = 5;
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
