//
//  NGTNetworkBaseModelResponse.m
//  Youdoneed
//
//  Created by JoeXu on 2017/7/13.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import "NGTNetworkBMResponse.h"

@implementation NGTNetworkBaseModelResponse
@synthesize code = _code;
@synthesize success = _success;
@synthesize message = _message;

- (NSString *)debugDescription{
    NSDictionary *info = [self ngt_keyValues];
    return [NSString stringWithFormat:@"\n----Response----\n%@\n--------\n",info];
}
- (NSString *)description{
    return [self debugDescription];
}

@end
