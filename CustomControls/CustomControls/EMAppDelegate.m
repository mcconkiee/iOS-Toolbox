//
//  EMAppDelegate.m
//  CustomControls
//
//  Created by Eric McConkie on 8/1/13.
//  Copyright (c) 2013 customcontrols. All rights reserved.
//

#import "EMAppDelegate.h"

#import "EMViewController.h"

@implementation EMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[UITabBarController alloc] init];
    self.window.rootViewController = self.viewController;
    
    
    [self.viewController setViewControllers:[NSArray arrayWithObjects:
                                             [[EMViewController alloc] init],
                                             [[UIViewController alloc] init],
                                             [[UIViewController alloc] init],
                                             [[UIViewController alloc] init]
                                             , nil]];
    UIImage *selectedImage0 = [UIImage imageNamed:@"tab_0_on"];
    UIImage *unselectedImage0 = [UIImage imageNamed:@"tab_0_off"];
    
    UIImage *selectedImage1 = [UIImage imageNamed:@"tab_1_on"];
    UIImage *unselectedImage1 = [UIImage imageNamed:@"tab_1_off"];
    
    UIImage *selectedImage2 = [UIImage imageNamed:@"tab_2_on"];
    UIImage *unselectedImage2 = [UIImage imageNamed:@"tab_2_off"];
    
    UIImage *selectedImage3 = [UIImage imageNamed:@"tab_3_on"];
    UIImage *unselectedImage3 = [UIImage imageNamed:@"tab_3_off"];
    
    
    UITabBar *tabBar = self.viewController.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    UITabBarItem *item3 = [tabBar.items objectAtIndex:3];
    
    
    [item0 setFinishedSelectedImage:selectedImage0 withFinishedUnselectedImage:unselectedImage0];
    [item1 setFinishedSelectedImage:selectedImage1 withFinishedUnselectedImage:unselectedImage1];
    [item2 setFinishedSelectedImage:selectedImage2 withFinishedUnselectedImage:unselectedImage2];
    [item3 setFinishedSelectedImage:selectedImage3 withFinishedUnselectedImage:unselectedImage3];
    
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
