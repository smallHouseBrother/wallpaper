//
//  AppDelegate.m
//  XMG
//
//  Created by 小马哥 on 2018/1/24.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "AppDelegate.h"
#import <UMMobClick/MobClick.h>
#import <UShareUI/UShareUI.h>
#import <UserNotifications/UserNotifications.h>
#import <IQKeyboardManager.h>
#import <Bugly/Bugly.h>
#import <JPUSHService.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "XMGLocationManager.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import "XGNavigationController.h"
#import "RootViewController.h"

@interface AppDelegate () <JPUSHRegisterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setJpushWithOption:launchOptions];
    [self setUMShare];  [self setUMMoblic];
    [self setBugly];    [self setAmap];

    [IQKeyboardManager sharedManager].enable = YES;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    RootViewController * rootVC = [[RootViewController alloc] init];
    XGNavigationController * rootNavi = [[XGNavigationController alloc] initWithRootViewController:rootVC];
    self.window.rootViewController = rootNavi;
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - 极光推送
- (void)setJpushWithOption:(NSDictionary *)launchOptions
{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:Jpush_Key channel:@"AppStore" apsForProduction:IsDebug ? 0 : 1];
}

#pragma mark - 友盟分享
- (void)setUMShare {
    [[UMSocialManager defaultManager] setUmSocialAppkey:UM_AppKey];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WeChat_AppKey appSecret:WeChat_Secret redirectURL:RedirectURL];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_AppKey appSecret:nil redirectURL:RedirectURL];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:Sina_AppKey  appSecret:Sina_Secret redirectURL:RedirectURL];
}

#pragma mark - 友盟统计
- (void)setUMMoblic {
    UMConfigInstance.appKey = UM_AppKey;
    [MobClick setAppVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    [MobClick startWithConfigure:UMConfigInstance];
}

#pragma mark - bugly
- (void)setBugly {
    [Bugly startWithAppId:Bugly_Key];
    BuglyConfig *config = [[BuglyConfig alloc] init];
    config.debugMode = IsDebug;
}

#pragma mark - 高德地图
- (void)setAmap {
    [AMapServices sharedServices].apiKey = AMAP_KEY;///开启定位
    [[XMGLocationManager shareLocationManager] startLocation];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken
{
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    XMGLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{///支持所有iOS系统
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{///仅支持iOS9以上系统，iOS8及以下系统不会回调
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{///支持目前所有iOS系统
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#pragma mark - 友盟推送
/*- (void)setUMMessage:(NSDictionary *)launchOptions {
 ///友盟推送
     [UMessage startWithAppkey:UM_APPKEY launchOptions:launchOptions];
     [UMessage registerForRemoteNotifications];
     [UMessage setLogEnabled:YES];
 
     if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)
     {
     //iOS10必须加下面这段代码。
         UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
         center.delegate = self;
         UNAuthorizationOptions types10 = UNAuthorizationOptionBadge | UNAuthorizationOptionAlert | UNAuthorizationOptionSound;
         [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
         if (granted) {
         //点击允许
         //这里可以添加一些自己的逻辑
         } else {
         //点击不允许
         //这里可以添加一些自己的逻辑
         }
    }];
     ///打开日志
    [UMessage setLogEnabled:YES];
    }
 }
 
 - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
 {
     [UMessage registerDeviceToken:deviceToken];
     //先删除本地存储的device_token 然后添加 避免切换账号后device_token发生串号
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     if ([defaults objectForKey:@"DEVICE_TOKEN"]) {
     [defaults removeObjectForKey:@"DEVICE_TOKEN"];
     }
     NSString * token = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""] stringByReplacingOccurrencesOfString: @">" withString: @""]                 stringByReplacingOccurrencesOfString: @" " withString: @""];
     [defaults setObject:token forKey:@"DEVICE_TOKEN"];
     [defaults synchronize];
 }
 
 - (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
 {
     XMGLog(@"获取device_token 失败：%@",error.userInfo);
 }
 
 ///iOS10以下使用这个方法接收通知
 - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
 {
     [UMessage didReceiveRemoteNotification:userInfo];
 
     if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive && [self.window.rootViewController isKindOfClass:[XGTabBarController class]]) {
     }
 }
 
 //iOS10新增：处理前台收到通知的代理方法
 -(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
 {
     NSDictionary * userInfo = notification.request.content.userInfo;
     if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
     {
     //应用处于前台时的远程推送接受
     //关闭U-Push自带的弹出框
     [UMessage setAutoAlert:NO];
     [UMessage didReceiveRemoteNotification:userInfo];
     if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive && [self.window.rootViewController isKindOfClass:[XGTabBarController class]]) {
     }
 
     }else{
     //应用处于前台时的本地推送接受
     }
     //当应用处于前台时提示设置，需要哪个可以设置哪一个
     completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
 }
 
 //iOS10新增：处理后台点击通知的代理方法
 - (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
     NSDictionary * userInfo = response.notification.request.content.userInfo;
     if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
     {
         //应用处于后台时的远程推送接受
         [UMessage didReceiveRemoteNotification:userInfo];
         if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive && [self.window.rootViewController isKindOfClass:[XGTabBarController class]]) {
         }
         }else{
         //应用处于后台时的本地推送接受
    }
}*/

@end
