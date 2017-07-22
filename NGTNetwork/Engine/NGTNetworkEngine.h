//
//  NGTNetworkEngine.h
//  Youdoneed
//
//  Created by JoeXu on 2017/7/13.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NGTNetworkEngineConfig.h"

#import "NGTNetworkEngineState.h"

@interface NGTNetworkEngine : NSObject

@property (nonatomic,strong) NGTNetworkEngineConfig *config;

@property (nonatomic,assign,readonly) NGTNetworkEngineState state;

+ (instancetype)engineWithConfig:(NGTNetworkEngineConfig *)config;
- (instancetype)initWithConfig:(NGTNetworkEngineConfig *)config;

- (void)cancel;

- (void)resume;

@end


@interface NGTNetworkEngine (Assist)

- (void)resumeWithCompletion:(void(^)(NSDictionary *,NSError *))completion;

@end




