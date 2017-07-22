//
//  NGTNetworkBMRequest.h
//  Youdoneed
//
//  Created by JoeXu on 2017/7/13.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import "NGTNetworkBaseModel.h"

#import "NGTNetworkEngine.h"

#define NGTNetworkBaseURL @"http://120.77.0.27:80"

#define NGTNetworkURL(suffix)\
({\
NSString *__NGTNetworkURL;\
if ([suffix hasPrefix:@"/"]){\
    __NGTNetworkURL = [NSString stringWithFormat:@"%@%@",NGTNetworkBaseURL,suffix];\
}else{\
    __NGTNetworkURL = [NSString stringWithFormat:@"%@/%@",NGTNetworkBaseURL,suffix];\
}\
__NGTNetworkURL;\
})\


@interface NGTNetworkBMRequest : NGTNetworkBaseModel

@property (nonatomic,copy,readonly) NSString *urlString;

- (NGTNetworkEngineConfig *)makeEngineConfig;



@end

@interface NGTNetworkBMRequest (DateFormat)
+ (NSDateFormatter *)dateFormatter;

+ (NSString *)dateString:(NSDate *)date;

+ (NSString *)currentDateString;
+ (NSString *)todayString;

@end

@interface NSArray (NGTNetworkBMRequest)

- (NSString *)ynnsJsonString;

@end

@interface NSDictionary (NGTNetworkBMRequest)

- (NSString *)ynnsJsonString;

@end


