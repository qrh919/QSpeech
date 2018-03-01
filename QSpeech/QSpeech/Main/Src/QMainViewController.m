//
//  QMainViewController.m
//  QSpeech
//
//  Created by qrh on 2018/1/10.
//  Copyright © 2018年 qrh. All rights reserved.
//

#import "QMainViewController.h"
#import "QMainCollectionCell.h"
#import "QChineseViewController.h"
#import "QMathViewController.h"
#import "QMoreViewController.h"
#import "QTranstionAnimation.h"

static NSString *const kMainCellId = @"kMainCellId";
static NSString *const kMainHeaderId = @"kMainHeaderId";

@interface QMainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation QMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"主页";
    [self initConfigure];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(collectionView.bounds.size.width, 45);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QMainCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMainCellId forIndexPath:indexPath];
    cell.title = _dataArr[indexPath.item];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        QMainCollectionHeader *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind withReuseIdentifier:kMainHeaderId forIndexPath:indexPath];
        return view;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    QMainCollectionCell *cell = (QMainCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.25 animations:^{
        cell.transform = CGAffineTransformScale(cell.transform, 2, 2);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            cell.transform = CGAffineTransformScale(cell.transform, 0.5, 0.5);
        } completion:^(BOOL finished) {
            switch (indexPath.item) {
                case 0:
                {
                    QChineseViewController *chineseVC = [[QChineseViewController alloc] init];
                    [self.navigationController pushViewController:chineseVC animated:YES];
                }
                    break;
                case 1:
                {
                    QMathViewController *mathVC = [[QMathViewController alloc] init];
                    [self.navigationController pushViewController:mathVC animated:YES];
                }
                    break;
                case 2:
                {
                    /*
                     UIModalTransitionStyleCoverVertical,   //垂直上入(默认)
                     UIModalTransitionStyleFlipHorizontal,  //水平反转
                     UIModalTransitionStyleCrossDissolve,   //渐显效果
                     UIModalTransitionStylePartialCurl      //翻页效果
                     */
                    QTranstionAnimation *animation = [QTranstionAnimation shareInstance];
                    QMoreViewController *moreVC = [[QMoreViewController alloc] init];
//                    moreVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                    moreVC.modalPresentationStyle = UIModalPresentationCustom;
                    moreVC.transitioningDelegate = animation;
                    [self presentViewController:moreVC animated:YES completion:^{
                        
                    }];
                    
//                    [self.navigationController pushViewController:moreVC animated:YES];
                }
                    break;
                default:
                    break;
            }
            cell.transform = CGAffineTransformIdentity;
        }];
    }];
}


#pragma mark - pageViews

-(void)initConfigure{
    self.dataArr = @[@"语文",@"数学",@"其他"];
    [self.view addSubview:self.collectionView];
}

-(UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width/2 - 30, self.view.bounds.size.width/2 - 30);
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 20, 0, 20);
        flowLayout.sectionHeadersPinToVisibleBounds = YES;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[QMainCollectionCell class]
            forCellWithReuseIdentifier:kMainCellId];
        [_collectionView registerClass:[QMainCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kMainHeaderId];
        
    }
    return _collectionView;
}

@end
