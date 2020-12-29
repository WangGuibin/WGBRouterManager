//
//  WGBRouterManager.h
//  ModuleStyle
//
//  Created by 王贵彬 on 2020/12/12.
// 主要参考了 https://github.com/LiliCode/Router-objc
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WGBRouterConnectorProtocol <NSObject>
/// 能否打开这个URL 每个Router子类自己实现各自的校验逻辑
- (BOOL)canOpenWithURL:(NSURL *)URL;
/// 通过URL获取对象
- (id)getObjectWithURL:(NSURL *)URL;
/// 配置URLScheme
- (NSArray<NSString *> *)URLSchemes;

@end

@interface WGBRouterWebConnector : NSObject<WGBRouterConnectorProtocol>

@end


@interface WGBRouterMyAppConnector : NSObject<WGBRouterConnectorProtocol>

@end


#define ROUTER(_URL_) [[WGBRouterManager shareManager] openURLString:_URL_]

/// 1. 实现<WGBRouterConnectorProtocol>方法
/// 2. 注册scheme
/// 3. 实现对应的TargetAction文件 匹配规则是文件名 + 方法名 + 参数query化(对大小写敏感 需注意传参别传错了) 
@interface WGBRouterManager : NSObject

+ (WGBRouterManager *)shareManager;
- (id)openURLString:(NSString *)URLString;
- (void)registerConnector:(id<WGBRouterConnectorProtocol>)connector;

@end

NS_ASSUME_NONNULL_END
