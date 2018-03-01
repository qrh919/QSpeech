
#import "QADView.h"
#import "UIImage+Extension.h"

static QADView *_qadView = nil;

@interface QADView()
{
    NSInteger jumpTime;//倒计时时间
}
@property (nonatomic, strong) UIImageView *adView;
@property (nonatomic, strong) UIButton *jumpBtn;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation QADView

+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _qadView = [[super alloc] initInstance];
        _qadView.frame = [UIScreen mainScreen].bounds;
        _qadView.backgroundColor = [UIColor redColor];
        [_qadView createSubViews];
    });
    return _qadView;
}

- (instancetype)initInstance{
    return [super init];
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"init error" reason:@"please use shareInstance instead of init" userInfo:nil];
    return [super init];
}

#pragma mark event
-(void)timeStart{
    if(_timer){
        [_timer invalidate];
    }
    self.alpha = 1;
    jumpTime = 5;
    [_jumpBtn setTitle:@"跳过" forState:UIControlStateNormal];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeCountdown:) userInfo:nil repeats:YES];
}

- (void)jumpAction:(UIButton *)sender{
    [UIView animateWithDuration:1 animations:^{
        self.transform = CGAffineTransformScale(self.transform, 2.0, 2.0);
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [_timer invalidate];
        self.transform = CGAffineTransformIdentity;
        [self removeFromSuperview];
        if(self.jumpOverBlock){
            self.jumpOverBlock();
        }
    }];
}

- (void)timeCountdown:(NSTimer *)time{
    if(_jumpBtn.hidden){
        _jumpBtn.hidden = NO;
    }
    NSString *titleStr = [NSString stringWithFormat:@"跳过(%ld)",jumpTime];
    [_jumpBtn setTitle:titleStr forState:UIControlStateNormal];
    if(jumpTime <= 0){
        [self performSelector:@selector(jumpAction:)withObject:nil];
        return;
    }
    jumpTime--;
}

#pragma page Views
- (void)createSubViews{
    [self addSubview:self.adView];
    [self addSubview:self.jumpBtn];
    [_adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self);
        make.center.equalTo(self);
    }];
    [_jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(45);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
    
}

-(UIImageView *)adView{
    if(!_adView){
        _adView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ad"]];
        _adView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _adView;
}

-(UIButton *)jumpBtn{
    if(!_jumpBtn){
        _jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _jumpBtn.layer.cornerRadius = 2;
        _jumpBtn.layer.masksToBounds = YES;
        [_jumpBtn setBackgroundImage:[UIImage imageWithColor:[UIColor darkGrayColor]] forState:UIControlStateNormal];
        [_jumpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _jumpBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_jumpBtn addTarget:self action:@selector(jumpAction:) forControlEvents:UIControlEventTouchUpInside];
        _jumpBtn.hidden = YES;
    }
    return _jumpBtn;
}

@end

