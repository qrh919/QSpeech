//
//  QChinesePoemListController.m
//  QSpeech
//
//  Created by qrh on 2018/1/11.
//  Copyright © 2018年 qrh. All rights reserved.
//

#import "QChinesePoemListController.h"
#import "QChinesePoemDetailViewController.h"
#import "QChinesePoem.h"

@interface QChinesePoemListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation QChinesePoemListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"诗词";
    [self initConfigure];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *defaultCellId = @"defaultCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultCellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    QChinesePoem *poem = _dataArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"⊙ %@",poem.name];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QChinesePoem *poem = _dataArr[indexPath.row];
    QChinesePoemDetailViewController *nextVC = [[QChinesePoemDetailViewController alloc] init];
    nextVC.navigationItem.title = poem.name;
    nextVC.poem = poem;
    [self.navigationController pushViewController:nextVC animated:YES];
}

-(void)initConfigure{
    _dataArr = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"poems" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *dict in array) {
        [_dataArr addObject:[QChinesePoem yy_modelWithDictionary:dict]];
    }
    [self.view addSubview:self.tableView];
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.rowHeight = 50;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
