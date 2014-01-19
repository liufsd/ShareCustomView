//
//  ActionViewIpadContent.h
//  Test
//
//  Created by liupeng on 1/17/14.
//  Copyright (c) 2014 crte. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActionViewIpadContentCell;

@protocol ActionViewIpadContentDelegate <NSObject>

- (int)numberOfItemsInActionSheet;
- (ActionViewIpadContentCell*)cellIpadForViewAtIndex:(NSInteger)index;
- (void)DidTapOnItemAtIndex:(NSInteger)index actionType:(NSInteger)type;

@end
@interface ActionViewIpadContent : UIView
-(id)initwithIconSheetDelegate:(id<ActionViewIpadContentDelegate>)delegate ItemCount:(int)cout;
@end


@interface ActionViewIpadContentCell : UIView
@property (nonatomic,retain)UIImageView* iconView;
@property (nonatomic,retain)UILabel*     titleLabel;
@property (nonatomic,assign)int          index;
@property (nonatomic,assign)int          actionType;
@end
