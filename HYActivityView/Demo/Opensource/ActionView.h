//
//  ActionView.h
//  suiyi
//
//  Created by brandy on 14-1-17.
//  Copyright (c) 2014年 XITEK. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UIControlStateAll UIControlStateNormal & UIControlStateSelected & UIControlStateHighlighted
#define SYSTEM_VERSION_LESS_THAN(version) ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedAscending)

@interface ActionView : UIView

- (void)showInView:(UIView *)theView;
-(void)dismiss;

@property(nonatomic,retain)UIButton* CancelButton;
@property UIView *transparentView;
@property BOOL visible;
@end
