//
//  JKHttpServiceManager.h
//  图片上传
//
//  Created by imac on 2017/6/16.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKHttpClientTool.h"

typedef void(^SuccessCallBack)(id responseObject,BOOL succe,NSDictionary *jsonDic);
typedef  void (^FailureCallBack)(NSError *error);

@interface JKHttpServiceManager : NSObject
/**
 * 数据传输
 * @param path 链接地址
 * @param params 字典
 * @param animated 控制提示动画
 */

+ (void)POST:(NSString*)path withParameters:(NSDictionary*)params success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated;
/**
 * 单图片含字典一起上传
 * @param path 链接地址
 * @param params 字典
 * @param imageData 图片Data数据
 * @param name 图片文件夹
 * @param animated 控制提示动画
 */
+ (void)POST:(NSString *)path Params:(NSDictionary *)params NSData:(NSData *)imageData key:(NSString *)name success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated;
/**
 * 多图上传
 * @param path 链接地址
 * @param params 字典
 * @param imageArr 图片Data数组
 * @param name 图片文件夹
 * @param animated 控制提示动画
 */
+ (void)POST:(NSString *)path Params:(NSDictionary*)params NSArray:(NSArray<NSData*>*)imageArr key:(NSString*)name success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated;



@end
