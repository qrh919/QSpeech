//
//  QChinesePoemDetailViewController.m
//  QSpeech
//
//  Created by qrh on 2018/1/11.
//  Copyright © 2018年 qrh. All rights reserved.
//

#import "QChinesePoemDetailViewController.h"
#import "QChinesePoem.h"

@interface QChinesePoemDetailViewController ()
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIButton *speakBtn;
@property (nonatomic, strong) NSString *speakString;
@property (nonatomic, strong) AVSpeechSynthesizer *synth;
@end

@implementation QChinesePoemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initConfigure];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self stopSpeech];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 关闭
 */
- (void)stopSpeech
{
    AVSpeechSynthesizer *talked = self.synth;
    if([talked isSpeaking]) {
        [talked stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
}

/**
 播放
 */
- (void)speakAction:(UIButton *)sender{
    if(!self.synth.speaking){
        //语音播报
        AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:self.speakString];
        
        utterance.pitchMultiplier = 1;
        utterance.rate = 0.4;
        utterance.postUtteranceDelay = 0.1;
        //中式发音
        AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
        //英式发音
        //    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];
        
        utterance.voice = voice;
        
        [self.synth speakUtterance:utterance];
    }
}

-(void)initConfigure{
    
    self.speakString = [NSString stringWithFormat:@"%@\n%@\n%@",self.poem.name,self.poem.author,self.poem.content];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self.speakString attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(self.poem.name.length+1, self.poem.author.length)];
    self.textLabel.attributedText = attrStr;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.textLabel];
    [self.view addSubview:self.speakBtn];
    WS(wSelf);
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.view).offset(50);
        make.centerX.equalTo(wSelf.view);
    }];
    [_speakBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.textLabel.mas_bottom).offset(50);
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerX.equalTo(wSelf.view);
    }];
}

-(UILabel *)textLabel{
    if(!_textLabel){
        _textLabel = [UILabel labelConfigure:^(UILabel *label) {
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont boldSystemFontOfSize:25];
            label.numberOfLines = 0;
        }];
    }
    return _textLabel;
}

-(UIButton *)speakBtn{
    if(!_speakBtn){
        _speakBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _speakBtn.layer.cornerRadius = 4;
        _speakBtn.layer.masksToBounds = YES;
        _speakBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _speakBtn.layer.borderWidth = 0.5;
        [_speakBtn setTitle:@"播放" forState:UIControlStateNormal];
        [_speakBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_speakBtn setTitleColor:[[UIColor orangeColor]colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [_speakBtn addTarget:self action:@selector(speakAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _speakBtn;
}

-(AVSpeechSynthesizer *)synth{
    if(!_synth){
        _synth = [[AVSpeechSynthesizer alloc]init];
    }
    return _synth;
}

@end
