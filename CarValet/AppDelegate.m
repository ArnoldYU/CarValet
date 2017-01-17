//
//  AppDelegate.m
//  CarValet
//
//  Created by 黄彬杨 on 2016/12/12.
//  Copyright © 2016年 黄彬杨. All rights reserved.
//

#import "AppDelegate.h"
#import "AboutViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIColor *Mocha = [UIColor colorWithDisplayP3Red:128.0/255 green:64.0/255.0 blue:0/255.0 alpha:1.0];//1
    
    [[UIButton appearance]setTitleColor:Mocha forState:UIControlStateNormal];//2
    [[UIBarButtonItem appearance] setTintColor:Mocha];
    
    UITabBarController *tabBarController = (UITabBarController*)self.window.rootViewController;//1
    //2
    AboutViewController *aboutViewController = [[AboutViewController alloc]initWithNibName:@"AboutViewController"
                                                                                    bundle:[NSBundle mainBundle]];
    UITabBarItem *aboutItem = [[UITabBarItem alloc]initWithTitle:@"About" //3
                                                           image:[UIImage imageNamed:@"tag"]
                                                             tag:0];
    [aboutViewController setTabBarItem:aboutItem];//4
    NSMutableArray *currentItems = [NSMutableArray arrayWithArray:tabBarController.viewControllers];//5
    [currentItems addObject:aboutViewController];//6
    [tabBarController setViewControllers:currentItems animated:NO];//7
    return YES;
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
