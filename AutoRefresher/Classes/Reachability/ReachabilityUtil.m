//
//  ReachabilityUtil.m
//  LYFaultDiagnosis
//
//  Created by YNKJMACMINI2 on 15/10/9.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import "ReachabilityUtil.h"
#import "Reachability.h"

@implementation ReachabilityUtil

+(BOOL)isReachable:(NSString*)host
{
    Reachability *r = [Reachability reachabilityWithHostName:host];
    if ([r currentReachabilityStatus] == NotReachable) {
        return NO;
    }
    return YES;
}
+(BOOL)isWifi:(NSString*)host
{
    Reachability * r=[Reachability reachabilityWithHostName:host];
    if ([r currentReachabilityStatus] == ReachableViaWiFi) {
        return YES;
    }
    return NO;
}
+(BOOL)isWWAN:(NSString*)host
{
    Reachability * r=[Reachability reachabilityWithHostName:host];
    if ([r currentReachabilityStatus] == ReachableViaWWAN) {
        return YES;
    }
    return NO;
}


@end
