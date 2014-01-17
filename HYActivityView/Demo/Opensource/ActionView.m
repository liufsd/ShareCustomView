//
//  ActionView.m
//  suiyi
//
//  Created by brandy on 14-1-17.
//  Copyright (c) 2014年 XITEK. All rights reserved.
//

#import "ActionView.h"

@implementation ActionView
@synthesize CancelButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        self.backgroundColor=[UIColor whiteColor];
 
        CancelButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        CancelButton.frame=CGRectMake(10, self.frame.size.height-40, self.frame.size.width-20, 30);
        [CancelButton setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
        [CancelButton setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateHighlighted];
        [CancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:CancelButton];
        
        self.transparentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
        self.transparentView.backgroundColor = [UIColor blackColor];
        self.transparentView.alpha = 0.0f;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.numberOfTapsRequired = 1;
        [self.transparentView addGestureRecognizer:tap];
    }
    return self;
}

- (void)removeFromView {
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^() {
                             self.transparentView.alpha = 0.0f;
                             self.center = CGPointMake(CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight([UIScreen mainScreen].bounds) + CGRectGetHeight(self.frame) / 2.0);
                         } completion:^(BOOL finished) {
                             [self.transparentView removeFromSuperview];
                             [self removeFromSuperview];
                             self.visible = NO;
                         }];
    
}

- (void)showInView:(UIView *)theView {
    
    [theView addSubview:self];
    [theView insertSubview:self.transparentView belowSubview:self];
    
    CGRect theScreenRect = [UIScreen mainScreen].bounds;
    
    float height;
    float x;
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        height = CGRectGetHeight(theScreenRect);
        x = CGRectGetWidth(theView.frame) / 2.0;
        self.transparentView.frame = CGRectMake(self.transparentView.center.x, self.transparentView.center.y, CGRectGetWidth(theScreenRect), CGRectGetHeight(theScreenRect));
    } else {
        height = CGRectGetWidth(theScreenRect);
        x = CGRectGetHeight(theView.frame) / 2.0;
        self.transparentView.frame = CGRectMake(self.transparentView.center.x, self.transparentView.center.y, CGRectGetHeight(theScreenRect), CGRectGetWidth(theScreenRect));
    }
    
    self.center = CGPointMake(x, height + CGRectGetHeight(self.frame) / 2.0);
    self.transparentView.center = CGPointMake(x, height / 2.0);
    
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^() {
                         self.transparentView.alpha = 0.4f;
                         if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
                             self.center = CGPointMake(x, (height - 20) - CGRectGetHeight(self.frame) / 2.0);
                         } else {
                             self.center = CGPointMake(x, height - CGRectGetHeight(self.frame) / 2.0);
                         }
                         
                     } completion:^(BOOL finished) {
                         self.visible = YES;
                     }];
}


-(void)dismiss
{
    
    [self removeFromView];
}


@end
