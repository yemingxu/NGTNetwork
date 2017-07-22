//
//  NGTNetworkBMRequest.m
//  Youdoneed
//
//  Created by JoeXu on 2017/7/13.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import "NGTNetworkBMRequest.h"

#import "MJExtension.h"


@implementation NGTNetworkBMRequest


- (NGTNetworkEngineConfig *)makeEngineConfig{
    NGTNetworkEngineConfig *config = [[NGTNetworkEngineConfig alloc] init];
    config.urlString = self.urlString;
    config.params = [self ngt_keyValues];
    return config;
}

- (NSString *)debugDescription{
    NSDictionary *info = [self mj_keyValues];
    return [NSString stringWithFormat:@"\n----Request Params----\n%@\n--------\n",@{@"URLString":(self.urlString ?:@""),@"RequestInfo":info}];
}
- (NSString *)description{
    return [self debugDescription];
}

@end


#pragma mark - Assist
@implementation NGTNetworkBMRequest (DateFormat)
+ (NSDateFormatter *)dateFormatter{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"YYYY-MM-dd hh:mm:ss";
    return format;
}

+ (NSString *)dateString:(NSDate *)date{
    NSDateFormatter *format = [self dateFormatter];
    return [format stringFromDate:date];
}

+ (NSString *)currentDateString{
    return [self dateString:[NSDate date]];
}
+ (NSString *)todayString{
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"YYYY-MM-dd";
    return [NSString stringWithFormat:@"%@ 00:00:00",[format stringFromDate:date]];
}
@end

@implementation NSArray (NGTNetworkBMRequest)

- (NSString *)ynnsJsonString{
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:nil];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end


@implementation NSDictionary (NGTNetworkBMRequest)

- (NSString *)ynnsJsonString{
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:nil];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end



