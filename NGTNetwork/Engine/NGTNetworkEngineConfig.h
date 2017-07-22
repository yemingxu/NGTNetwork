//
//  NGTNetworkEngineConfig.h
//  Youdoneed
//
//  Created by JoeXu on 2017/7/13.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NGTNetworkRequestType.h"

@interface NGTNetworkEngineConfig : NSObject<NSCopying>

@property (nonatomic,assign) NGTNetworkRequestType requestType;

@property (nonatomic,copy) NSString *urlString;

@property (nonatomic,copy) NSDictionary *params;

@property (nonatomic,copy) void(^completion)(NSDictionary *response,NSError *error);

@end
