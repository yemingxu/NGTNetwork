//
//  NGTNetworkEngine.m
//  Youdoneed
//
//  Created by JoeXu on 2017/7/13.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import "NGTNetworkEngine.h"

#import "AFNetworking.h"

#import "NGTNetworkManager.h"

@interface NGTNetworkEngine()

@property (nonatomic,assign,readwrite) NGTNetworkEngineState state;

@end
@implementation NGTNetworkEngine

+ (instancetype)engineWithConfig:(NGTNetworkEngineConfig *)config{
    return [[NGTNetworkEngine alloc] initWithConfig:config];
}
- (instancetype)initWithConfig:(NGTNetworkEngineConfig *)config{
    if (self = [super init]){
        
        _config = config;
        _state = NGTNetworkEngineStateCompleted;
        
    }
    return self;
}
- (instancetype)init{
    return [self initWithConfig:nil];
}

- (void)cancel{
    if (self.state == NGTNetworkEngineStateRunning){
        self.state = NGTNetworkEngineStateCanceled;
    }
}

- (void)resume{
    if (self.config == nil) return;
    
    if (self.state == NGTNetworkEngineStateRunning){
        return;
    }
//    __weak typeof(self) weakSelf = self;
    
    
    self.state = NGTNetworkEngineStateRunning;
    
    if (self.config.requestType == NGTNetworkRequestTypePOST){
        
        [[NGTNetworkManager manager] POST:self.config.urlString param:self.config.params completion:^(id result, NSError *error) {
           
            if (self.state == NGTNetworkEngineStateCanceled){
                return ;
            }
            
            if (self.config.completion == nil){
                return;
            }
            
            self.config.completion(result, error);
            
        }];
        
    }else if(self.config.requestType == NGTNetworkRequestTypeGET){
        
        [[NGTNetworkManager manager] GET:self.config.urlString param:self.config.params completion:^(id result, NSError *error) {
            
            if (self.state == NGTNetworkEngineStateCanceled){
                return ;
            }
            
            if (self.config.completion == nil){
                return;
            }
            
            self.config.completion(result, error);
            
        }];
        
    }
    
    
}
- (void)dealloc{
    NSLog(@"%@____Dealloc",self);
}

@end


@implementation NGTNetworkEngine (Assist)

- (void)resumeWithCompletion:(void(^)(NSDictionary *,NSError *))completion{
    
    self.config.completion = completion;
    
    [self resume];
    
}

@end




