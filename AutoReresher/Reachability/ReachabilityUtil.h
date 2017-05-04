//
//  ReachabilityUtil.h
//  LYFaultDiagnosis
//
//  Created by YNKJMACMINI2 on 15/10/9.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReachabilityUtil : NSObject
+(BOOL)isReachable:(NSString*)host;
+(BOOL)isWifi:(NSString*)host;
+(BOOL)isWWAN:(NSString*)host;
@end
