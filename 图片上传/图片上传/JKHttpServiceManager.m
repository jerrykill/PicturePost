//
//  JKHttpServiceManager.m
//  图片上传
//
//  Created by imac on 2017/6/16.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "JKHttpServiceManager.h"

@implementation JKHttpServiceManager


+ (void)POST:(NSString *)path withParameters:(NSDictionary *)params success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated {
    [[JKHttpClientTool sharedManager] POST:path parameters:params progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        //判断返回值是否成功
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"status"]];
        BOOL succe=NO;
        if ([str isEqualToString:@"1"]) {
            succe = YES;
        }
        NSLog(@"%@",dic[@"data"]);
        success(responseObject,succe,dic);
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        NSLog(@"%@",error.description);
//        [SXLoadingView showAlertHUD:@"网络故障" duration:0.5];
    }];
}


+ (void)POST:(NSString *)path Params:(NSDictionary *)params NSData:(NSData *)imageData key:(NSString *)name success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated {
   [[JKHttpClientTool sharedManager]POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
       if (imageData) {
           NSString *file  =[NSString stringWithFormat:@"%@.jpg",imageData];
           [formData appendPartWithFileData:imageData name:name fileName:file mimeType:@"image/png/jpeg/jpg"];
       }
   } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSDictionary *dic = (NSDictionary*)responseObject;
       //判断返回值是否成功
       NSString *str = [NSString stringWithFormat:@"%@",dic[@"status"]];
       BOOL succe=NO;
       if ([str isEqualToString:@"1"]) {
           succe = YES;
       }
       NSLog(@"%@",dic[@"data"]);
       success(responseObject,succe,dic);
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       NSLog(@"%@",error.description);
       fail(error);

   }];
}

+ (void)POST:(NSString *)path Params:(NSDictionary*)params NSArray:(NSArray<NSData*>*)imageArr key:(NSString*)name success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated {
    [[JKHttpClientTool sharedManager] POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (imageArr.count) {
            for (int i=0; i<imageArr.count; i++) {
                NSData *data = imageArr[i];
                NSString *file  =[NSString stringWithFormat:@"%@.jpg",data];
                NSString *names = [NSString stringWithFormat:@"%@%d",name,i+1];
                [formData appendPartWithFileData:data name:names fileName:file mimeType:@"image/png/jpeg/jpg"];
            }
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        //判断返回值是否成功
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"status"]];
        BOOL succe=NO;
        if ([str isEqualToString:@"1"]) {
            succe = YES;
        }
        NSLog(@"%@",dic[@"data"]);
        success(responseObject,succe,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
        fail(error);
    }];
}

@end
