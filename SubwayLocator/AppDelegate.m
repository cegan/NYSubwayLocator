//
//  AppDelegate.m
//  SubwayLocator
//
//  Created by Casey Egan  on 5/14/14.
//  Copyright (c) 2014 Casey Egan . All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate



- (void) setUserInterfaceDefaults{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],
                                                          NSForegroundColorAttributeName,
                                                          [UIFont fontWithName:@"HelveticaNeue-Medium" size:18], NSFontAttributeName, nil]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
   
    [self setUserInterfaceDefaults];
    
    
    self.window.rootViewController  = [[UINavigationController alloc] initWithRootViewController:[[SubwayLocatorViewController alloc] initSubwayLocatorViewController]];
    [self.window makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application{
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    
   
}

- (void) applicationDidBecomeActive:(UIApplication *)application{
    
    
//    SubwayLocatorService *slc = [[SubwayLocatorService alloc] init];
//    
//    
//    [slc retrieveSubwayStations];
   
}

- (void)applicationWillTerminate:(UIApplication *)application{
    
   
}

@end
