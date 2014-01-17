//
//  AWActionSheetIpad.h
//  Eudic_ting_iOS
//
//  Created by liupeng on 12/26/13.
//  Copyright (c) 2013 eudic. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AWActionSheetIpadCell;

@protocol AWActionSheetIpadDelegate <NSObject>

- (int)numberOfItemsInActionSheet;
- (AWActionSheetIpadCell*)cellForViewAtIndex:(NSInteger)index;
- (void)DidTapOnItemAtIndex:(NSInteger)index actionType:(NSInteger)type;

@end
@interface AWActionSheetIpad : UIView
-(id)initwithIconSheetDelegate:(id<AWActionSheetIpadDelegate>)delegate ItemCount:(int)cout;
@end


@interface AWActionSheetIpadCell : UIView
@property (nonatomic,retain)UIImageView* iconView;
@property (nonatomic,retain)UILabel*     titleLabel;
@property (nonatomic,assign)int          index;
@property (nonatomic,assign)int          actionType;
@end
