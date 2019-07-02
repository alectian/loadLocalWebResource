//
//  AppDelegate.h
//  iOS_Server
//
//  Created by Coder on 2019/7/2.
//  Copyright © 2019 Alec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CVCocoaHTTPServeriOS/CVCocoaHTTPServeriOS-umbrella.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) HTTPServer *localHttpServer;
@property (nonatomic,copy) NSString *port;

@end

