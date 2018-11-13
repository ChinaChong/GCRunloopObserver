//
//  GCRunloopObserver.m
//  RunloopOptimizeTableView
//
//  Created by 崇 on 2018/11/12.
//  Copyright © 2018 崇. All rights reserved.
//

#import "GCRunloopObserver.h"

@interface GCRunloopObserver(){
    NSTimer *timer;
}

@property (nonatomic, strong) NSMutableArray *taskArray;

@end

@implementation GCRunloopObserver

+ (instancetype)runloopObserver {
    static dispatch_once_t once;
    static GCRunloopObserver *observer;
    dispatch_once(&once, ^{
        observer = [[GCRunloopObserver alloc] init];
    });
    return observer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerFiredMethod) userInfo:nil repeats:YES];
        [self runloopBeforeWaiting];
    }
    return self;
}

- (void)addTask:(void(^)(void))task {
    if (task) {
        [self.taskArray addObject:task];
    }
}

- (void)runloopBeforeWaiting {
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopBeforeWaiting, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        if (self.taskArray.count == 0) {
            return;
        }
        // 取出任务
        void(^task)(void) = self.taskArray.firstObject;
        // 执行任务
        task();
        // 第一个任务出队列
        [self.taskArray removeObjectAtIndex:0];
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    CFRelease(observer);
}

- (void)timerFiredMethod {
    
}

- (NSMutableArray *)taskArray {
    if (_taskArray == nil) {
        _taskArray = [NSMutableArray array];
    }
    return _taskArray;
}

@end
