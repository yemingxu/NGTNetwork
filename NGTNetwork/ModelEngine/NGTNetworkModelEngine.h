//
//  NGTNetworkEngineModel.h
//  Youdoneed
//
//  Created by JoeXu on 2017/7/13.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NGTNetworkBMResponse.h"

#import "NGTNetworkBMRequest.h"

@interface NGTNetworkEngineModel : NSObject

@property (nonatomic,strong) NGTNetworkBMRequest *request;

@property (nonatomic,assign) Class responseClass;

@property (nonatomic,copy) void(^completion)(id,NSError *);

@property (nonatomic,assign,readonly) BOOL isRuning;


+ (instancetype)engineWithRequest:(NGTNetworkBMRequest *)request
                    responseClass:(Class)responseClass
                       completion:(void(^)(id,NSError *))completion;

- (void)resume;

- (void)cancel;
@end



@interface NGTNetworkEngineModel (Assist)

- (void)resumeWithResponseClass:(Class)responseClass
                     completion:(void(^)(id,NSError *))completion;

- (void)resumeWithResponseClassName:(NSString *)responseClassName
                         completion:(void(^)(id,NSError *))completion;

+ (NGTNetworkEngineModel *)resumeWithRequest:(NGTNetworkBMRequest *)request
            responseClass:(Class)responseClass
               completion:(void(^)(id,NSError *))completion;

@end





@interface NGTNetworkGroupModelEngine: NGTNetworkEngineModel

@property (nonatomic,readonly,copy) NGTNetworkGroupModelEngine* (^linkTo)(NGTNetworkGroupModelEngine *);
@property (nonatomic,readonly,copy) NGTNetworkGroupModelEngine* (^unlink)(NGTNetworkGroupModelEngine *);

@property (nonatomic,assign,getter=isNeedAllLinkedComlpetedTodoNext) BOOL needAllLinkedComlpetedTodoNext;

- (void)unlinkAll;
@end

@interface NGTNetworkEmptyModelEngine: NGTNetworkGroupModelEngine

@end






