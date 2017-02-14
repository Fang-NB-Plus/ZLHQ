//
//  AppDelegate.m
//  liangqing
//
//  Created by Macbook 13.3 on 2017/1/24.
//  Copyright © 2017年 方正泉. All rights reserved.
//

#import "AppDelegate.h"
#import "SunViewController.h"
#import "BMViewController.h"
#import "GuideViewController.h"
#import "ASQMyShopVC.h"
#import "configHead.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(index) name:isLoad object:nil];
    /*
    id a = [[NSUserDefaults standardUserDefaults] objectForKey:@"load"];
    if (!a) {
        [self guide];
    }else{
        [self index];
    }
     */
    [self index];
    

    
    return YES;
}

- (void)guide{
    GuideViewController *vc = [[GuideViewController alloc] init];
    self.window.rootViewController = vc;
    
}

- (void)index{
    
    UITabBarController *tab = [[UITabBarController alloc] init];
    ASQMyShopVC *sunvc       = [[ASQMyShopVC alloc] init];
    BMViewController  *bmvc  = [BMViewController new];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:sunvc];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:bmvc];
    
    tab.viewControllers = @[nav1,nav2];
    
    nav1.tabBarItem.title         = @"阳光政务";
    nav2.tabBarItem.title         = @"便民服务";
    nav1.tabBarItem.selectedImage = [UIImage imageNamed:@"maintab_sun_click"];
    nav1.tabBarItem.image         = [UIImage imageNamed:@"maintab_sun"];
    nav2.tabBarItem.selectedImage = [UIImage imageNamed:@"maintab_oa_click"];
    nav2.tabBarItem.image         = [UIImage imageNamed:@"maintab_oa"];
    nav1.tabBarItem.titlePositionAdjustment = UIOffsetMake(22, -15);
    nav1.tabBarItem.imageInsets = UIEdgeInsetsMake(6, -44, -6, 44);
    
    nav2.tabBarItem.titlePositionAdjustment = UIOffsetMake(22, -15);
    nav2.tabBarItem.imageInsets = UIEdgeInsetsMake(6, -44, -6, 44);
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0x0099ff),NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateSelected];
    
    
    self.window.rootViewController = tab;
    


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
-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:isLoad object:nil];
}


@end
