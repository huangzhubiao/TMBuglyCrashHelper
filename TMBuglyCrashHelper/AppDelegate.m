//
//  AppDelegate.m
//  TMBuglyCrashHelper
//
//  Created by cocomanber on 2017/9/4.
//  Copyright © 2017年 cocomanber. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<BuglyDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self configBuglyFile];
    
    return YES;
}

-(void)configBuglyFile
{
    // Get the default config
    BuglyConfig * config = [[BuglyConfig alloc] init];
    config.delegate = self;
    
    //SDK Debug信息开关, 默认关闭
    config.debugMode = YES;
    //卡顿监控开关，默认关闭
    config.blockMonitorEnable = YES;
    
    //卡顿监控判断间隔，单位为秒
    config.blockMonitorTimeout = 1.5;
    
    //控制台日志上报开关，默认开启
    config.consolelogEnable = NO;
    
    //页面信息记录开关，默认开启
    config.viewControllerTrackingEnable = YES;
    
#if DEBUG
    // 设置自定义渠道标识  开发环境
    config.channel = @"Development";
    [Bugly startWithAppId:@"db7e37a404" developmentDevice:YES config:config];
    
#else
    // 设置自定义渠道标识  线上环境
    config.channel = @"Product";
    [Bugly startWithAppId:@"db7e37a404" developmentDevice:NO config:config];
#endif
    
    [Bugly setUserIdentifier:[NSString stringWithFormat:@"User: %@", [UIDevice currentDevice].name]];
    [Bugly setUserValue:[NSProcessInfo processInfo].processName forKey:@"Process"];
}

#pragma mark - Bugly代理 - 捕获异常,回调(@return 返回需上报记录，随 异常上报一起上报)
//附件信息crash_attach.log文件
- (NSString *)attachmentForException:(NSException *)exception {
    
#ifdef DEBUG
    return [NSString stringWithFormat:@"我是携带信息:%@",[self redirectNSLogToDocumentFolder]];
#endif
    
    return @"测试一下";
}

#pragma mark - 保存日志文件

- (NSString *)redirectNSLogToDocumentFolder {
    //    //如果已经连接Xcode调试则不输出到文件
    //    if(isatty(STDOUT_FILENO)) {
    //        return nil;
    //    }
    //    UIDevice *device = [UIDevice currentDevice];
    //    if([[device model] hasSuffix:@"Simulator"]){
    //        //在模拟器不保存到文件中
    //        return nil;
    //    }
    //获取Document目录下的Log文件夹，若没有则新建
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Log"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:logDirectory];
    if (!fileExists) {
        [fileManager createDirectoryAtPath:logDirectory  withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //每次启动后都保存一个新的日志文件中
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    NSString *logFilePath = [logDirectory stringByAppendingFormat:@"/%@.txt",dateStr];
    // freopen 重定向输出输出流，将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
    return [[NSString alloc] initWithContentsOfFile:logFilePath encoding:NSUTF8StringEncoding error:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
