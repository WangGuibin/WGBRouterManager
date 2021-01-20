//
//  WGBPackLib.m
//  WGBPackLib
//
//  Created by 王贵彬 on 2021/1/15.
//

#import "WGBPackLib.h"

@implementation WGBPackLib
+ (UIImage *)getJPGImage{
    //方式① 寻找bundle获取path
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"libResource.bundle/2" ofType:@"jpg"];
    return [UIImage imageWithContentsOfFile:path];
}

+ (UIImage *)getPNGImage{
    //方式② 直接找到bundle目录获取图片资源
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"1" ofType:@"png" inDirectory:@"libResource.bundle"];
    return [UIImage imageWithContentsOfFile:path];
}

@end
