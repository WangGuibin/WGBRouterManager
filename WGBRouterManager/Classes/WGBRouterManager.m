//
//  WGBRouterManager.m
//  ModuleStyle
//
//  Created by 王贵彬 on 2020/12/12.
//

#import "WGBRouterManager.h"
#import <UIKit/UIKit.h>

@implementation WGBRouterWebConnector

- (BOOL)canOpenWithURL:(nonnull NSURL *)URL {
    return [self.URLSchemes containsObject:URL.scheme];
}

- (nonnull id)getObjectWithURL:(nonnull NSURL *)URL {
    NSLog(@"%@ 暂不处理",URL.absoluteString);
#warning 此处增加webView逻辑
    return nil;
}

- (NSArray<NSString *> *)URLSchemes{
    return @[@"http",@"https"];
}

@end


@implementation WGBRouterMyAppConnector

- (BOOL)canOpenWithURL:(nonnull NSURL *)URL {
    return [self.URLSchemes containsObject:URL.scheme];
}

/// 解析URL的参数
- (nonnull id)getObjectWithURL:(nonnull NSURL *)URL {
    NSString *path = [[URL.path componentsSeparatedByString:@"/"] lastObject];
    NSString *action = [path copy];
    if (URL.query.length) {
        action = [action stringByAppendingString:@":"];
    }
    NSDictionary *params = [self getQueryParametersWithURL:URL];
    NSString *targetName = URL.host;
    
    //TargetAction
    return [self performTarget:targetName action:action parameter:params];
}

/**
 * 从url获取query参数转字典
 */
- (NSDictionary *)getQueryParametersWithURL:(nonnull NSURL *)URL{
    NSArray *pairs = [URL.query componentsSeparatedByString:@"&"];
    NSMutableDictionary *userParams = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        if (kv.count == 2) {
            NSString *key = kv.firstObject;
            NSString *value = [kv.lastObject stringByRemovingPercentEncoding];
            [userParams setObject:value forKey:key];
        }
    }
    return [NSDictionary dictionaryWithDictionary:userParams];
}


- (id)performTarget:(NSString *)target
             action:(NSString *)action
          parameter:(NSDictionary *)parameter{
    if (!target.length || !action.length) {
        return nil;
    }
    
    Class class = NSClassFromString(target);
    SEL selector = NSSelectorFromString(action);
    NSMethodSignature *signature = [class methodSignatureForSelector:selector];
    
    if (!strcmp(signature.methodReturnType, @encode(void))) {
        ((void (*)(id, SEL, id))[class methodForSelector:selector])(class, selector, parameter);
        return nil;
    }
    return ((id (*)(id, SEL, id))[class methodForSelector:selector])(class, selector, parameter);
}

- (NSArray<NSString *> *)URLSchemes{
#warning 此处自定义跳转的Scheme
    return @[@"myapp"];
}
@end



@interface WGBRouterManager ()

@property (strong, nonatomic) NSMutableDictionary <NSString *, id<WGBRouterConnectorProtocol>> *cacheDic;

@end


@implementation WGBRouterManager

static WGBRouterManager *_router = nil;

+ (WGBRouterManager *)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _router = [[WGBRouterManager alloc] init];
    });
    return _router;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _router = [super allocWithZone:zone];
    });
    
    return _router;
}

- (id)copyWithZone:(NSZone *)zone {
    return _router;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _router;
}


static NSString * EncodeString(NSString * uncodeString) {
    if (uncodeString.length == 0) {
        return nil;
    }
    // 先尝试使用原始字符串创建url
    NSURL *url = [NSURL URLWithString:uncodeString];
    if (url == nil) {// 如果url为nil，说明uncodeString中含有特殊字符串，则调用下面的方法进行转码
        NSString *encodeString = [uncodeString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        url = [NSURL URLWithString:encodeString.length >0 ? encodeString : uncodeString];
    }
    return url.absoluteString;
}

- (id)openURLString:(NSString *)URLString{
    if (!URLString || URLString.length == 0) {
        return nil;
    }
    
    URLString = EncodeString(URLString);
    NSURL *URL = [NSURL URLWithString:URLString];
    id <WGBRouterConnectorProtocol> connector = [self.cacheDic objectForKey:URL.scheme];
    
    if (!connector) {
        return nil;
    }
    
    if ([connector canOpenWithURL:URL]) {
        return [connector getObjectWithURL:URL];
    }
    return nil;
}

- (void)registerConnector:(id<WGBRouterConnectorProtocol>)connector{
    if (!connector || !connector.URLSchemes.count) {
        return;
    }
    
    if (![connector conformsToProtocol:@protocol(WGBRouterConnectorProtocol)]) {
        NSAssert(1, @"注册的对象没有遵守WGBRouterConnectorProtocol协议~");
        return;
    }
    for (NSString *scheme in connector.URLSchemes) {
        [self.cacheDic setObject:connector forKey:scheme];
    }
}

- (NSMutableDictionary<NSString *,id<WGBRouterConnectorProtocol>> *)cacheDic{
    if (!_cacheDic) {
        _cacheDic = [NSMutableDictionary dictionary];
    }
    return _cacheDic;
}

@end
