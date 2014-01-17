//
//  ShareTools.h
//  Test
//
//  Created by liupeng on 1/17/14.
//  Copyright (c) 2014 crte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionViewContent.h"
#import "ActionView.h"
@interface ShareTools : NSObject<ActionViewContentDelegate>
@property (nonatomic, retain)NSArray         *shareImageList;
@property (nonatomic, retain)NSArray         *shareImageValue;
@property (nonatomic, retain)NSArray         *shareImageActionTypes;
@property (nonatomic, retain)ActionView      *shareView;
+(ShareTools *)shareToolsInstance;
-(void)showShareView:(UIViewController *)uiViewController;
-(void)shareWithMode:(int)action fromSender:(UIView*)sender shareContent:(NSString*)someText;
@end
