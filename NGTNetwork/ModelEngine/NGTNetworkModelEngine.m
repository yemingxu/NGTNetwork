//
//  NGTNetworkEngineModel.m
//  Youdoneed
//
//  Created by JoeXu on 2017/7/13.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import "NGTNetworkModelEngine.h"

#import "NGTNetworkErrorParse.h"

#import "MJExtension.h"

@interface NGTNetworkEngineModel()

@property (nonatomic,strong) NGTNetworkEngine *engine;


@property (nonatomic,copy) void(^callback)(id,NSError *);

@end
@implementation NGTNetworkEngineModel

+ (instancetype)engineWithRequest:(NGTNetworkBMRequest *)request
                    responseClass:(Class)responseClass
                       completion:(void(^)(id,NSError *))completion{
    NGTNetworkEngineModel *engineModel = [[self alloc] init];
    
    engineModel.request = request;
    engineModel.responseClass = responseClass;
    engineModel.completion = completion;

    return engineModel;
}

- (void)setCompletion:(void (^)(id, NSError *))completion{
    _completion = [completion copy];
    self.callback = [completion copy];
}
- (void)resume{
    if (self.request == nil){return;}
    
    if (self.engine.state == NGTNetworkEngineStateRunning){
        [self cancel];
    }
    self.engine.config = [self.request makeEngineConfig];

    Class __responseClass = self.responseClass;
//    void(^__callback)(id,NSError *) = [self.callback copy];
    
    NSString *urlString = self.engine.config.urlString.copy;
    __weak typeof(self) weakSelf = self;
    [self.engine.config setCompletion:^(NSDictionary *response,NSError *error){
        
        NSLog(@"\n---Response---\n%@\n--------\n",@{@"URLString":urlString,@"Response":(response?:@"NULL"),@"Error":(error?:@"NULL")});

        if (weakSelf.callback == nil){return;}
                
        if (error){
            weakSelf.callback(nil,error);
        }else{
            
            NSError *responseErr = [NGTNetworkErrorParse parseResponse:response];
            if(responseErr == nil){
                id model = [__responseClass mj_objectWithKeyValues:response];
                weakSelf.callback(model,nil);
            }else{
                weakSelf.callback(nil,responseErr);
            }

        }
        
    }];
    
    NSLog(@"\n---Request Params---\n%@\n--------\n",@{@"URLString":urlString,@"Request":self.engine.config.params});

    [self.engine resume];
}

- (void)cancel{
    [self.engine cancel];
}
- (BOOL)isRuning{
    return (self.engine.state == NGTNetworkEngineStateRunning);
}
- (NGTNetworkEngine *)engine{
    if (!_engine) {
        _engine = [[NGTNetworkEngine alloc] init];
    }
    return _engine;
}
@end


#pragma mark - NGTNetworkModelEngine (Assist)
@implementation NGTNetworkEngineModel (Assist)
- (void)resumeWithResponseClass:(Class)responseClass
                     completion:(void(^)(id,NSError *))completion{
    
    self.responseClass = responseClass;
    self.completion = completion;
    [self resume];
    
}
- (void)resumeWithResponseClassName:(NSString *)responseClassName
                         completion:(void(^)(id,NSError *))completion{
    
    Class responseClass = NSClassFromString(responseClassName);
    [self resumeWithResponseClass:responseClass completion:completion];
    
}
+ (NGTNetworkEngineModel *)resumeWithRequest:(NGTNetworkBMRequest *)request
            responseClass:(Class)responseClass
               completion:(void(^)(id,NSError *))completion{
    
    NGTNetworkEngineModel *engineModel = [[NGTNetworkEngineModel alloc] init];
    engineModel.request = request;
    [engineModel resumeWithResponseClass:responseClass completion:completion];
    return engineModel;
}
@end









#pragma mark - NGTNetworkGroupModelEngine

@interface NGTNetworkGroupModelEngine()

@property (nonatomic,strong) NSMutableArray<NGTNetworkGroupModelEngine *> *willLinkToModelList;

@end
@implementation NGTNetworkGroupModelEngine

- (NGTNetworkGroupModelEngine *(^)(NGTNetworkGroupModelEngine *))linkTo{
    __weak typeof(self) weakSelf = self;
    return ^NGTNetworkGroupModelEngine *(NGTNetworkGroupModelEngine *model) {
        
        if (model == nil){
            return nil;
        }
        
        if (![weakSelf.willLinkToModelList containsObject:model]){
            [weakSelf.willLinkToModelList addObject:model];
        }
        
        return model;
    };
}
- (NGTNetworkGroupModelEngine *(^)(NGTNetworkGroupModelEngine *))unlink{
    
    __weak typeof(self) weakSelf = self;
    return ^NGTNetworkGroupModelEngine *(NGTNetworkGroupModelEngine *model) {
        
        if (model && [weakSelf.willLinkToModelList containsObject:model]){
            [self.willLinkToModelList removeObject:model];
        }
        
        return model;
    };
}

- (void)unlinkAll{
    [self.willLinkToModelList removeAllObjects];
}

- (void)setCompletion:(void (^)(id, NSError *))completion{
    [super setCompletion:completion];
    
    __weak typeof(self) weakSelf = self;
    void(^__completion)(id,NSError *) = [completion copy];
    self.callback = ^(id resp, NSError *err) {
        if (__completion){
            __completion(resp,err);
        }
        
        for (NGTNetworkGroupModelEngine *model in weakSelf.willLinkToModelList) {
            [model resume];
        }
    };
}

- (NSMutableArray<NGTNetworkGroupModelEngine *> *)willLinkToModelList{
    if (!_willLinkToModelList){
        _willLinkToModelList = @[].mutableCopy;
    }
    return _willLinkToModelList;
}
@end



@implementation NGTNetworkEmptyModelEngine
- (NGTNetworkBMRequest *)request{
    return nil;
}
- (Class)responseClass{
    return nil;
}
- (void)resume{
    if (self.callback == nil){
        self.completion = nil;
    }
    self.callback(nil, nil);
    
}
@end


