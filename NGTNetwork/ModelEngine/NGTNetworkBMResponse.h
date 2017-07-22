//
//  NGTNetworkBaseModelResponse.h
//  Youdoneed
//
//  Created by JoeXu on 2017/7/13.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import "NGTNetworkBaseModel.h"

@protocol NGTNetworkBMResponseProtocol <NSObject>

@property (nonatomic,copy) NSString * code;

@property (nonatomic,assign) BOOL success;

@property (nonatomic,copy) NSString * message;

@end


@interface NGTNetworkBaseModelResponse : NGTNetworkBaseModel<NGTNetworkBMResponseProtocol>

@end
