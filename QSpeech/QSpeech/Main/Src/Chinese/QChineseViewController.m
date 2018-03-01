//
//  QChineseViewController.m
//  QSpeech
//
//  Created by qrh on 2018/1/10.
//  Copyright © 2018年 qrh. All rights reserved.
//

#import "QChineseViewController.h"
#import "QChineseCollectionCell.h"
#import "QChinesePoemListController.h"
#import "QChineseABCViewController.h"

static NSString *const kChineseCellId = @"kChineseCellId";

@interface QChineseViewController ()
<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation QChineseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"语文";
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
    QChineseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kChineseCellId forIndexPath:indexPath];
    cell.title = _dataArr[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    QChineseCollectionCell *cell = (QChineseCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.25 animations:^{
        cell.transform = CGAffineTransformScale(cell.transform, 2, 2);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            cell.transform = CGAffineTransformScale(cell.transform, 0.5, 0.5);
        } completion:^(BOOL finished) {
            switch (indexPath.item) {
                case 0:
                {
                    QChineseABCViewController *chineseVC = [[QChineseABCViewController alloc] init];
                    [self.navigationController pushViewController:chineseVC animated:YES];
                }
                    break;
                case 1:
                {
                    QChinesePoemListController *mathVC = [[QChinesePoemListController alloc] init];
                    [self.navigationController pushViewController:mathVC animated:YES];
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
    self.dataArr = @[@"ABC",@"诗词"];
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
        [_collectionView registerClass:[QChineseCollectionCell class]
            forCellWithReuseIdentifier:kChineseCellId];
        
    }
    return _collectionView;
}


@end
