//
//  ShareTools.m
//  Test
//
//  Created by liupeng on 1/17/14.
//  Copyright (c) 2014 crte. All rights reserved.
//

#import "ShareTools.h"
#import "ActionView.h"
#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#define shareContentDefault @"... from https://github.com/79144876/ShareCustomView"

@implementation ShareTools

static ShareTools *_shareTools = nil;
+(ShareTools *)shareToolsInstance
{
    if (_shareTools == nil)
    {
        _shareTools = [[ShareTools alloc] init];
    }
    return _shareTools;
}

#pragma -- showAction
-(void)showShareView:(UIViewController *)uiViewController isFollow:(BOOL)follow
{
    if (self.shareImageList==nil) {
        self.shareImageList = @[@"sns_icon_1.png", @"sns_icon_6.png", @"sns_icon_24.png", @"sns_icon_22.png", @"sns_icon_23.png", @"sns_icon_19.png", @"sns_icon_18.png", @"sns_icon_21.png", @"sns_icon_21.png", @"sns_icon_21.png", @"sns_icon_18.png", @"sns_icon_21.png", @"sns_icon_21.png", @"sns_icon_21.png"];
        self.shareImageValue = @[@"新浪微博", @"QQ空间", @"QQ",@"微信好友",@"朋友圈",@"短信",@"邮件",@"拷贝",@"邮件",@"拷贝",@"邮件",@"拷贝",@"邮件",@"拷贝"];
        self.shareImageActionTypes = @[[NSNumber numberWithInteger:ShareTypeSinaWeibo],[NSNumber numberWithInteger:ShareTypeQQSpace], [NSNumber numberWithInteger:ShareTypeQQ],[NSNumber numberWithInteger:ShareTypeWeixiSession],[NSNumber numberWithInteger:ShareTypeWeixiTimeline], [NSNumber numberWithInteger:ShareTypeSMS],[NSNumber numberWithInteger:ShareTypeMail], [NSNumber numberWithInteger:ShareTypeCopy],[NSNumber numberWithInteger:ShareTypeMail], [NSNumber numberWithInteger:ShareTypeCopy],[NSNumber numberWithInteger:ShareTypeMail], [NSNumber numberWithInteger:ShareTypeCopy],[NSNumber numberWithInteger:ShareTypeMail], [NSNumber numberWithInteger:ShareTypeCopy]];
    }
    CGRect baseRect = [[UIScreen mainScreen] bounds];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        ActionViewContent *sheetContentView = [[ActionViewContent alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
        [sheetContentView initwithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
        self.shareView=[[ActionView alloc] initWithFrame:CGRectMake(0, [[UIApplication sharedApplication] keyWindow].frame.size.height, baseRect.size.width, 350)];
        [self.shareView addSubview:sheetContentView];
        [self.shareView updateFollowStatus:follow];
        [self.shareView showInView:uiViewController.view];
        [sheetContentView release];
    }

}

#pragma -- ActionViewContentDelegate
- (int)numberOfItemsInActionSheet
{
     return self.shareImageList.count;
}
- (ActionViewContentCell*)cellForViewAtIndex:(NSInteger)index
{
    ActionViewContentCell* cell = [[[ActionViewContentCell alloc] init] autorelease];
    
    [[cell iconView] setImage:[UIImage imageNamed:[@"Resource.bundle/Icon/" stringByAppendingString:[self.shareImageList objectAtIndex:index]]]];
    [[cell titleLabel] setText:[ self.shareImageValue objectAtIndex:index]];
    cell.index = index;
    cell.actionType = [[self.shareImageActionTypes objectAtIndex:index] integerValue];
    return cell;
}
- (void)DidTapOnItemAtIndex:(NSInteger)index actionType:(NSInteger)type
{
    NSLog(@"didTap: %d",index);
    [self.shareView dismiss];
    [self shareWithMode:type fromSender:nil shareContent:shareContentDefault];
}

#pragma -- share lib action
- (void)shareWithMode:(int)action fromSender:(UIView*)sender shareContent:(NSString*)someText
{
    //create share content
    id<ISSContent> publishContent = [ShareSDK content:someText
                                       defaultContent:@""
                                                image:nil
                                                title:nil
                                                  url:@"http://eudic.net"
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeText];
    //create container
    id<ISSContainer> container = [ShareSDK container];
//    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    
    AppDelegate* delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    id<ISSShareOptions> shareOptions;
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStylePopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:delegate.viewDelegate];
    
    shareOptions= [ShareSDK defaultShareOptionsWithTitle:@"title"
                                         oneKeyShareList:nil
                                          qqButtonHidden:YES
                                   wxSessionButtonHidden:YES
                                  wxTimelineButtonHidden:YES
                                    showKeyboardOnAppear:NO
                                       shareViewDelegate:delegate.viewDelegate
                                     friendsViewDelegate:delegate.viewDelegate
                                   picViewerViewDelegate:nil];
    
//    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
//                                    [ShareSDK userFieldWithType:SSUserFieldTypeUid value:SINA_UUID],
//                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
//                                    nil]];
    ShareType actionType;
    switch (action) {
        case ShareTypeSinaWeibo:
        {
            actionType = ShareTypeSinaWeibo;
        }
            break;
        case ShareTypeTencentWeibo:
        {
            actionType = ShareTypeTencentWeibo;
        }
            break;
        case ShareTypeQQSpace:
        {
            actionType = ShareTypeQQSpace;
        }
            break;
        case ShareTypeQQ:
        {
            actionType = ShareTypeQQ;
        }
            break;
        case ShareTypeEvernote:
        {
            actionType = ShareTypeEvernote;
        }
            break;
        case ShareTypeWeixiSession:
        {
            actionType = ShareTypeWeixiSession;
        }
            break;
        case ShareTypeWeixiTimeline:
        {
            actionType = ShareTypeWeixiTimeline;
        }
            break;
        case ShareTypeSMS:
        {
            actionType = ShareTypeSMS;
        }
            break;
        case ShareTypeMail:
        {
            actionType = ShareTypeMail;
        }
            break;
        case ShareTypeCopy:
        {
            actionType = ShareTypeCopy;
        }
            break;
        case ShareTypeAirPrint:
        {
            actionType = ShareTypeAirPrint;
        }
            break;
        default:
            actionType = ShareTypeCopy;
            break;
    }
    
    //show share view
    [ShareSDK showShareViewWithType:actionType
                          container:container
                            content:publishContent
                      statusBarTips:YES
                        authOptions:authOptions
                       shareOptions:shareOptions
                             result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                 
                                 if (state == SSPublishContentStateSuccess)
                                 {
                                     NSLog(@"success");
                                 }
                                 else if (state == SSPublishContentStateFail)
                                 {
                                     NSLog(@"Fail !error code == %d, error code == %@", [error errorCode], [error errorDescription]);
                                 }
                             }];
}

@end
