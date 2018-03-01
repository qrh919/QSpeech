//
//  QChineseABCViewController.m
//  QSpeech
//
//  Created by qrh on 2018/1/11.
//  Copyright © 2018年 qrh. All rights reserved.
//

#import "QChineseABCViewController.h"

@interface QChineseABCViewController ()
@property (nonatomic, strong) UIButton *showBtn;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) AVSpeechSynthesizer *synth;

@end

@implementation QChineseABCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ABC";
    [self initConfigure];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)swipe:(UISwipeGestureRecognizer *)sender{
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
        {
            NSInteger count = self.dataArr.count-1;
            if(_index < count){
                _index++;
                
                POPBasicAnimation *baseAnima = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
                baseAnima.fromValue = @0.1;
                baseAnima.toValue = @1;
                baseAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
                baseAnima.duration = 1;
                [_showBtn pop_addAnimation:baseAnima forKey:nil];
                [_showBtn setTitle:self.dataArr[_index] forState:UIControlStateNormal];
            }   
        }
            break;
        case UISwipeGestureRecognizerDirectionRight:
        {
            if(_index>0){
                _index--;
                
                POPBasicAnimation *baseAnima = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
                baseAnima.fromValue = @0.1;
                baseAnima.toValue = @1;
                baseAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
                baseAnima.duration = 1;
                [_showBtn pop_addAnimation:baseAnima forKey:nil];
                [_showBtn setTitle:self.dataArr[_index] forState:UIControlStateNormal];
            }
        }
            break;
        default:
            break;
    }
}

-(void)speakAction:(UIButton *)sender{
    
    POPSpringAnimation *popAnima = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    popAnima.beginTime = CACurrentMediaTime();
    popAnima.fromValue = [NSValue valueWithCGSize:CGSizeMake(0.1, 0.1)];
    popAnima.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    popAnima.springBounciness = 10.f;
    [sender.layer pop_addAnimation:popAnima forKey:@"scaleAnim"];
    if(!self.synth.speaking){
        NSLog(@"%@",self.dataArr[_index]);
        //语音播报
        AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:self.dataArr[_index]];
        
        utterance.pitchMultiplier = 1;
        utterance.rate = 0.4;
        utterance.postUtteranceDelay = 0.1;
        //英式发音
        //    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];
        AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
        utterance.voice = voice;
        
        [self.synth speakUtterance:utterance];
    }
}

-(void)initConfigure{
    _index = 0;
    [self.view addSubview:self.showBtn];
    // 添加向左轻扫手势
    UISwipeGestureRecognizer *swipeGestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    [self.view addGestureRecognizer:swipeGestureRecognizerLeft];
    swipeGestureRecognizerLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    // 添加向右轻扫手势
    UISwipeGestureRecognizer *swipeGestureRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    [self.view addGestureRecognizer:swipeGestureRecognizerRight];
    swipeGestureRecognizerRight.direction = UISwipeGestureRecognizerDirectionRight;
}

-(UIButton *)showBtn{
    if(!_showBtn){
        _showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _showBtn.frame = CGRectMake(self.view.bounds.size.width/2-100, 100, 200, 200);
        _showBtn.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
        [_showBtn setTitle:self.dataArr[0] forState:UIControlStateNormal];
        _showBtn.titleLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:60];
        [_showBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        _showBtn.layer.cornerRadius = 5;
        _showBtn.layer.masksToBounds = YES;
        _showBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _showBtn.layer.borderWidth = 5;
        [_showBtn addTarget:self action:@selector(speakAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showBtn;
}
-(NSArray *)dataArr{
    return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",];
}
-(AVSpeechSynthesizer *)synth{
    if(!_synth){
        _synth = [[AVSpeechSynthesizer alloc]init];
    }
    return _synth;
}
@end
