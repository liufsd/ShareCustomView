//
//  ShareTools.m
//  Test
//
//  Created by liupeng on 1/17/14.
//  Copyright (c) 2014 crte. All rights reserved.
//

#import "ShareTools.h"
#import "ActionView.h"
#import <ShareSDK/ShareSDK.h>

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
-(void)showShareView:(UIViewController *)uiViewController
{
    if (self.shareImageList==nil) {
        self.shareImageList = @[@"sns_icon_1.png", @"sns_icon_6.png", @"sns_icon_24.png", @"sns_icon_22.png", @"sns_icon_23.png", @"sns_icon_19.png", @"sns_icon_18.png", @"sns_icon_21.png", @"sns_icon_21.png", @"sns_icon_21.png", @"sns_icon_18.png", @"sns_icon_21.png", @"sns_icon_21.png", @"sns_icon_21.png"];
        self.shareImageValue = @[@"新浪微博", @"QQ空间", @"QQ",@"微信好友",@"朋友圈",@"短信",@"邮件",@"拷贝",@"邮件",@"拷贝",@"邮件",@"拷贝",@"邮件",@"拷贝"];
        self.shareImageActionTypes = @[[NSNumber numberWithInteger:ShareTypeSinaWeibo],[NSNumber numberWithInteger:ShareTypeQQSpace], [NSNumber numberWithInteger:ShareTypeQQ],[NSNumber numberWithInteger:ShareTypeWeixiSession],[NSNumber numberWithInteger:ShareTypeWeixiTimeline], [NSNumber numberWithInteger:ShareTypeSMS],[NSNumber numberWithInteger:ShareTypeMail], [NSNumber numberWithInteger:ShareTypeCopy],[NSNumber numberWithInteger:ShareTypeMail], [NSNumber numberWithInteger:ShareTypeCopy],[NSNumber numberWithInteger:ShareTypeMail], [NSNumber numberWithInteger:ShareTypeCopy],[NSNumber numberWithInteger:ShareTypeMail], [NSNumber numberWithInteger:ShareTypeCopy]];
    }
    CGRect baseRect = [[UIScreen mainScreen] bounds];
    ActionViewContent *sheetContentView = [[ActionViewContent alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    [sheetContentView initwithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
    ActionView* actionview=[[ActionView alloc] initWithFrame:CGRectMake(0, [[UIApplication sharedApplication] keyWindow].frame.size.height, baseRect.size.width, 350)];
    [actionview addSubview:sheetContentView];
    [actionview showInView:uiViewController.view];
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
//    cell.actionType = [[self.shareImageActionTypes objectAtIndex:index] integerValue];
    return cell;
}
- (void)DidTapOnItemAtIndex:(NSInteger)index actionType:(NSInteger)type
{
    NSLog(@"didTap: %d",index);
}
@end
