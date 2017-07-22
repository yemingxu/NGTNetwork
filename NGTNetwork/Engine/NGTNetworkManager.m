//
//  NGTNetworkEngine.m
//  Youdoneed
//
//  Created by JoeXu on 2017/7/13.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import "NGTNetworkManager.h"

#import "AFNetworking.h"

@interface NGTNetworkManager()

@property (nonatomic, strong) AFHTTPSessionManager *myManager;

@end
@implementation NGTNetworkManager

+ (instancetype)manager{
    
    static NGTNetworkManager *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[NGTNetworkManager alloc] init];
    });
    return obj;
}
- (instancetype)init
{
    self = [super init];
    if (self == nil) {return  nil;}
    
    
    
    return self;
}

/**
 *  GET请求
 */
- (void)GET:(NSString *)url param:(NSDictionary *)param completion:(NGTNetworkCompletion)completion{
    
    
    //发起get请求
    [self.myManager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            result = responseObject;
        }else{
            //将返回的数据转成json数据格式
            result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        }
        
        if (completion) completion(result,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion) completion(nil,error);

    }];
}

/**
 *  POST请求
 */
- (void)POST:(NSString *)url param:(NSDictionary *)param completion:(NGTNetworkCompletion)completion{
    
    
    [self.myManager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            result = responseObject;
        }else{
            //将返回的数据转成json数据格式
            result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        }
        
        if (completion) completion(result,nil);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion) completion(nil,error);

    }];
}


/**
 *  NSData上传文件
 */
- (void)uploadDataWithURLStr:(NSString *)urlStr
                  parameters:(id)parameters
                    fromData:(NSData *)fromData
                    fileName:(NSString *)fileName
                    mimeType:(NSString *)mimeType
                    progress:(void(^)(NSProgress *uploadProgress))progress
                  completion:(NGTNetworkCompletion)completion{
    
    NSDictionary *dict = parameters ?: @{@"files":@"1234"};
    
    [self.myManager POST:urlStr parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传文件参数
        
        [formData appendPartWithFileData:fromData name:@"files" fileName:fileName mimeType:mimeType];
//        [formData appendPartWithFileData:fromData name:@"files" fileName:@"123.png" mimeType:@"image/png"];

        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
//        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        if(progress){progress(uploadProgress);}
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        
        NSDictionary *result;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            result = responseObject;
        }else{
            //将返回的数据转成json数据格式
            result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        }

        if(completion) completion(result,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion) completion(nil,error);

    }];
    
}

/**
 *  NSData上传文件
 */
- (void)downloadDataWithFilePath:(NSString *)filePath
                      targetPath:(NSString *)targetPath
                      progress:(void(^)(NSProgress *uploadProgress))progress
                    completion:(NGTNetworkCompletion)completion{
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]];
    
    NSString *_targetPath = targetPath.copy;
    [self.myManager downloadTaskWithRequest:request progress:progress destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL URLWithString:_targetPath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if(error){
            
            if (completion) completion(nil,error);
            
        }else{
            
            if (completion) completion(response,error);
            
        }
        
    }];
    
}




#pragma mark - Getter & Setter
- (AFHTTPSessionManager *)myManager{
    if (!_myManager) {
        _myManager = [AFHTTPSessionManager manager];
        _myManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _myManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _myManager.requestSerializer.timeoutInterval = 10;
        
        [_myManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        _myManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
        
        //        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    }
    return _myManager;
}
@end





