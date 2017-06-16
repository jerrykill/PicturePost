//
//  ViewController.m
//  图片上传
//
//  Created by imac on 2017/6/16.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "ViewController.h"
#import "JKHttpServiceManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark ==单图片上传==
- (void)uploadImageOne {
    //接口地址随便更改
    NSString *url = @"www.baidu.com";
   //字典
    NSDictionary *params = @{@"test":@"1"};
    //图片data
    UIImage *goodImage = [[UIImage alloc]init];//随便替换成什么图片
    NSData *imageData = UIImageJPEGRepresentation(goodImage, 0.5);//压缩上传

   [JKHttpServiceManager POST:url Params:params NSData:imageData key:@"goods" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
       if (succe) {
           NSLog(@"上传成功");
       }
   } failure:^(NSError *error) {

   } animated:YES];
}
#pragma mark ==多图上传==
- (void)uploadImageArrary {
    //接口地址随便更改
    NSString *url = @"www.baidu.com";
    //字典
    NSDictionary *params = @{@"test":@"1"};
    //图片data数组
    UIImage *goodImage = [[UIImage alloc]init];//随便替换成什么图片
    NSData *imageData = UIImageJPEGRepresentation(goodImage, 0.5);//压缩上传
    NSArray *imageArr = @[imageData,imageData,imageData];
    [JKHttpServiceManager POST:url Params:params NSArray:imageArr key:@"goods" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSLog(@"上传成功");
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

#pragma mark ==图片数组使用加密上传==
- (void)uploadImageChange {
    //接口地址随便更改
    NSString *url = @"www.baidu.com";

    UIImage *goodImage = [[UIImage alloc]init];//随便替换成什么图片
    NSData *imageData = UIImageJPEGRepresentation(goodImage, 0.5);//压缩上传
    NSArray *imageArr = @[imageData,imageData,imageData];
    NSMutableArray *list = [NSMutableArray array];
    for (int i=0; i<imageArr.count; i++) {
        NSData *image = imageArr[i];
        NSString *s = [image base64Encoding];
        [list addObject:s];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:list options:NSJSONWritingPrettyPrinted error:nil];
     NSString *imageString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [JKHttpServiceManager POST:url withParameters:@{@"test":@"1",@"goods":imageString} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSLog(@"上传成功");
        }
    } failure:^(NSError *error) {

    } animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
