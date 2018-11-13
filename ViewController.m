//
//  ViewController.m
//  RunloopOptimizeTableView
//
//  Created by 崇 on 2018/11/12.
//  Copyright © 2018 崇. All rights reserved.
//

#import "ViewController.h"
#import "TestTableViewCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
    [self requestData];
}

- (void)requestData {
    NSLog(@"请求数据中...");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i < 100; i++) {
            NSMutableArray *arrM = [NSMutableArray array];
            for (int i = 0; i < 3; i++) {
                NSString *imgName = [NSString stringWithFormat:@"img%d.jpg", i+3];
                [arrM addObject:imgName];
            }
            [self.dataArray addObject:arrM];
        }
        [self.tableView reloadData];
    });
}

- (void)configTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TestTableViewCell class] forCellReuseIdentifier:@"TestTableViewCell"];
    [self.view addSubview:self.tableView];
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestTableViewCell" forIndexPath:indexPath];
    [cell setData:self.dataArray[indexPath.row]];
    return cell;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


@end
