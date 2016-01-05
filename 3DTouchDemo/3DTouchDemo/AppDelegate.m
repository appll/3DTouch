//
//  AppDelegate.m
//  3DTouchDemo
//
//  Created by App on 1/4/16.
//  Copyright © 2016 App. All rights reserved.
//

#import "AppDelegate.h"

#define BundleId [NSBundle mainBundle].bundleIdentifier

@interface AppDelegate ()

@property (nonatomic, strong) UIApplicationShortcutItem *currentShortItem;
//@property (nonatomic, assign) int count;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    BOOL result = YES;
//    _count = 0;
    
    //系统版本适配
    if(IOS_VERSION < 9.0) return result;
    //判断是否是从shortitem启动的程序
    if (launchOptions[@"UIApplicationLaunchOptionsShortcutItemKey"]) {
        _currentShortItem = launchOptions[@"UIApplicationLaunchOptionsShortcutItemKey"];
        //这个返回值很重要、返回no，不会再调用performActionForShortcutItem这个回调方法
        result = NO;
    }
    
    //判断是否已经创建了shortitem、
    NSArray *items = [UIApplication sharedApplication].shortcutItems;
    if (items.count == 0) {
        [self createShortIcon];
    }
    
    return result;
}

-(void)createShortIcon{
//    NSString *bundleIdentifier = BundleId;[NSBundle mainBundle].bundleIdentifier
    
    UIApplicationShortcutIcon *shortIcon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    UIApplicationShortcutItem *shortItem1 = [[UIApplicationShortcutItem alloc] initWithType:[NSString stringWithFormat:@"%@.First", BundleId] localizedTitle:@"FirstItem" localizedSubtitle:nil icon:shortIcon1 userInfo:nil];
    
    UIApplicationShortcutIcon *shortIcon2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose];
    UIApplicationShortcutItem *shortItem2 = [[UIApplicationShortcutItem alloc] initWithType:[NSString stringWithFormat:@"%@.Second", BundleId] localizedTitle:@"SecondItem" localizedSubtitle:nil icon:shortIcon2 userInfo:nil];
    
    [[UIApplication sharedApplication] setShortcutItems:@[shortItem1, shortItem2]];
}

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
//    _count--;
    [self handleItem:shortcutItem];
}

-(void)handleItem:(UIApplicationShortcutItem *)shortItem{
    //处理shortitem事件
    if ([shortItem.type isEqualToString:[NSString stringWithFormat:@"%@.First", BundleId]]) {
        NSLog(@"First Item---");
    }else if ([shortItem.type isEqualToString:[NSString stringWithFormat:@"%@.Second", BundleId]]){
        NSLog(@"Second Item---");
    }
    [self showAlert];
}

-(void)showAlert{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"aaa" message:[NSString stringWithFormat:@"%d", 22] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if(!_currentShortItem) return;
//    _count++;
    [self handleItem:_currentShortItem];
    _currentShortItem = nil;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
