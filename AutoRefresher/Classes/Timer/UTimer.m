//
//  UTimer.m
//  NSTimerTest
//
//  Created by UKJMACMINI2 on 16/2/15.
//  Copyright © 2016年 UKJMACMINI2. All rights reserved.
//

#import "UTimer.h"

@interface UTimer()
@property (strong, nonatomic)NSTimer *timer;
@property (assign,nonatomic)NSTimeInterval interval;
@end

@implementation UTimer
-(id)initWithRefreshInterval:(NSTimeInterval)interval
{
    self=[super init];
    if(self)
    {
        self.interval = interval;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        [self stop];
        _state = TimerStateStop;
    }
    return self;
}
-(void)startAfterInterval
{
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.interval]];
    _state = TimerStateStart;
}

-(void)start
{
    [self.timer setFireDate:[NSDate distantPast]];
    _state = TimerStateStart;
}
-(void)stop
{
    [self.timer setFireDate:[NSDate distantFuture]];
    _state = TimerStateStop;
}
-(void)invalid
{
    [self.timer invalidate];
    self.timer = nil;
    _state = TimerStateInvalid;
}
-(void)changedInterval:(NSTimeInterval)interval
{
    //记录timer当前状态
    TimerState currentState = self.state;
    //修改timer interval
    [self.timer invalidate];
    self.interval = interval;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    //恢复timer状态
    switch (currentState) {
        case TimerStateStart:
            [self start];
            break;
        case TimerStateStop:
            [self stop];
            break;
        case TimerStateInvalid:
            [self invalid];
            break;
    }
}

- (void)timerFireMethod:(NSTimer *)timer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(doTimerTask)]) {
        [self.delegate doTimerTask];
    }
}
@end
