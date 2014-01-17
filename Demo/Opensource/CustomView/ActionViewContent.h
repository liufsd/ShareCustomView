//
//  ActionViewContent.h
//  Test
//
//  Created by liupeng on 1/17/14.
//  Copyright (c) 2014 crte. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActionViewContentCell;

@protocol ActionViewContentDelegate <NSObject>

- (int)numberOfItemsInActionSheet;
- (ActionViewContentCell*)cellForViewAtIndex:(NSInteger)index;
- (void)DidTapOnItemAtIndex:(NSInteger)index actionType:(NSInteger)type;

@end
@interface ActionViewContent : UIView
-(id)initwithIconSheetDelegate:(id<ActionViewContentDelegate>)delegate ItemCount:(int)cout;
@end


@interface ActionViewContentCell : UIView
@property (nonatomic,retain)UIImageView* iconView;
@property (nonatomic,retain)UILabel*     titleLabel;
@property (nonatomic,assign)int          index;
@property (nonatomic,assign)int          actionType;
@end