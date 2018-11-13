//
//  GCRunloopObserver.h
//  RunloopOptimizeTableView
//
//  Created by 崇 on 2018/11/12.
//  Copyright © 2018 崇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCRunloopObserver : NSObject

+ (instancetype)runloopObserver;

- (void)addTask:(void(^)(void))task;

@end
