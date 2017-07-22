//
//  NGTNetworkEngineConfig.m
//  Youdoneed
//
//  Created by JoeXu on 2017/7/13.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import "NGTNetworkEngineConfig.h"

@implementation NGTNetworkEngineConfig
- (instancetype)init{
    if (self = [super init]) {
        _requestType = NGTNetworkRequestTypePOST;
    }
    return self;
}
- (id)copyWithZone:(nullable NSZone *)zone{
    
    NGTNetworkEngineConfig *output = [[NGTNetworkEngineConfig alloc] init];
    
    output.urlString = self.urlString;
    output.params = [self.params copy];
    output.completion = [self.completion copy];
    output.requestType = self.requestType;
    
    return output;
}

- (void)dealloc{
    NSLog(@"%@____Dealloc",self);
}

@end
