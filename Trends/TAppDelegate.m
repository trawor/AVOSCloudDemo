//
//  TAppDelegate.m
//  Trends
//
//  Created by Travis on 13-11-11.
//  Copyright (c) 2013年 AVOSCloud. All rights reserved.
//

#import "TAppDelegate.h"
#import "TModel.h"

#import "TNavView.h"

@implementation TAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [application setStatusBarHidden:NO];
    model;
    [AVOSCloud setApplicationId:@"f7y5k5rupnx5ahxpglqxkahvjor1mv7j93l8lw56cap1xa9r" clientKey:@"p3k9lqbnw72gld3nlbnc3q27l9ho154tt1nnmitkfevptoat"];
    
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    [self.window makeKeyAndVisible];
    
    [[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:@"bottom_bar"]
                            forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    
    
    
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
    
    UINavigationController *vc=[board instantiateInitialViewController];
    self.window.rootViewController=vc;
    
    TNavView *nav=[TNavView shared];
    if ([TModel osVersion]>=7) {
        CGPoint center=nav.center;
        center.y+=[UIApplication sharedApplication].statusBarFrame.size.height;
        nav.center=center;
        [application setStatusBarStyle:UIStatusBarStyleLightContent];
        
        UIView *statBg=[[UIView alloc] initWithFrame:[UIApplication sharedApplication].statusBarFrame];
        statBg.backgroundColor=[UIColor blackColor];
        [self.window addSubview:statBg];
    }
    
    [vc.view addSubview:nav];
    
    
    return YES;
}


@end
