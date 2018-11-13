//
//  TestTableViewCell.m
//  RunloopOptimizeTableView
//
//  Created by 崇 on 2018/11/12.
//  Copyright © 2018 崇. All rights reserved.
//

#import "TestTableViewCell.h"
#import "GCRunloopObserver.h"

@interface TestTableViewCell()

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *imgViewArray;

@end

@implementation TestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imgViewArray = [NSMutableArray array];
        
        NSInteger count = 3;
        for (int i = 0; i < count; i++) {
            UIImageView *imgView = [[UIImageView alloc] init];
            [self.imgViewArray addObject:imgView];
            [self.contentView addSubview:imgView];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat screenWidth = self.contentView.bounds.size.width;
    CGFloat width = (screenWidth - (self.imgViewArray.count+1)*10.0f) / self.imgViewArray.count;
    CGFloat height = self.contentView.bounds.size.height;
    for (int i = 0; i < self.imgViewArray.count; i++) {
        UIImageView *imgView = self.imgViewArray[i];
        imgView.frame = CGRectMake( (i+1)*10 + i*width, 0, width, height);
    }
}

- (void)setData:(NSArray *)dataArray {
    _dataArray = dataArray;
    for (int i = 0; i < 3; i++) {
        __weak typeof(self) weakSelf = self;
        [[GCRunloopObserver runloopObserver] addTask:^{
            UIImageView *imgView = weakSelf.imgViewArray[i];
            UIImage *img = [UIImage imageNamed:dataArray[i]];
            imgView.image = img;
        }];
    }
}

@end
