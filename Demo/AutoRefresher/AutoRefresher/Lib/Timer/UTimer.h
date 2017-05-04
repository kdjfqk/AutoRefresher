//
//  UTimer.h
//  NSTimerTest
//
//  Created by UKJMACMINI2 on 16/2/15.
//  Copyright © 2016年 UKJMACMINI2. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    TimerStateStart,
    TimerStateStop,
    TimerStateInvalid,
} TimerState;

@protocol UTimerProtocol<NSObject>


-(void)doTimerTask;

@end


@interface UTimer : NSObject
@property (weak,nonatomic) id<UTimerProtocol> delegate;
@property (assign,nonatomic,readonly) TimerState state;
-(id)initWithRefreshInterval:(NSTimeInterval)interval;
//开启timer，等待Interval时长之后触发第一次响应
-(void)startAfterInterval;
//开启timer，立即触发第一次响应
-(void)start;
-(void)stop;
-(void)invalid;
-(void)changedInterval:(NSTimeInterval)interval;
@end
