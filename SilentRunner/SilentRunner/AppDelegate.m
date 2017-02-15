//
//  AppDelegate.m
//  SilentRunner
//
//  Created by Andrew Batutin on 12/12/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "AppDelegate.h"
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"Hi Folks!");
}

@end
