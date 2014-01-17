//
//  AppDelegate.h
//  Test
//
//  Created by crte on 13-11-4.
//  Copyright (c) 2013年 crte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGViewDelegate.h"
#import "WBApi.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
{
    
    enum WXScene _scene;
    AGViewDelegate *_viewDelegate;
    SSInterfaceOrientationMask _interfaceOrientationMask;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,readonly) AGViewDelegate *viewDelegate;
@end
