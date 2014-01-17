//
//  ActionView.h
//  suiyi
//
//  Created by brandy on 14-1-17.
//  Copyright (c) 2014年 XITEK. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UIControlStateAll UIControlStateNormal & UIControlStateSelected & UIControlStateHighlighted
#define IOS7_OR_LATER		( [[UIDevice currentDevice].systemVersion doubleValue]>=7.0)

//#define USEToolBarStyle

@interface ActionView : UIToolbar

- (void)showInView:(UIView *)theView;
-(void)dismiss;

@property(nonatomic,retain)UIButton* CancelButton;
@property(nonatomic,retain)UIButton* FollowButton;
@property(nonatomic,retain)UIView *transparentView;
@property BOOL visible;
@property BOOL isFollow;

- (void)updateFollowStatus:(BOOL)follow;
@end
