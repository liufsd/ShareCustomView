//
//  AWActionSheetIpad.m
//  Eudic_ting_iOS
//
//  Created by liupeng on 12/26/13.
//  Copyright (c) 2013 eudic. All rights reserved.
//

#import "AWActionSheetIpad.h"
#define itemPerPage 9

@interface AWActionSheetIpad()<UIScrollViewDelegate>
@property (nonatomic, retain)UIScrollView* scrollView;
@property (nonatomic, retain)UIPageControl* pageControl;
@property (nonatomic, retain)NSMutableArray* items;
@property (nonatomic, assign)id<AWActionSheetIpadDelegate> IconDelegate;
@end
@implementation AWActionSheetIpad
@synthesize scrollView;
@synthesize pageControl;
@synthesize items;
@synthesize IconDelegate;
-(void)dealloc
{
    IconDelegate= nil;
    [scrollView release];
    [pageControl release];
    [items release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, 320, 120*3)] autorelease];
        [scrollView setPagingEnabled:YES];
        [scrollView setBackgroundColor:[UIColor clearColor]];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        [scrollView setDelegate:self];
        [scrollView setScrollEnabled:YES];
        [scrollView setBounces:NO];
        
        [self addSubview:scrollView];

        self.pageControl = [[[UIPageControl alloc] initWithFrame:CGRectMake(100, 115*3, 0, 20)] autorelease];
            [pageControl setNumberOfPages:0];
            [pageControl setCurrentPage:0];
            [pageControl addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
            [self addSubview:pageControl];
    }
    return self;
}
-(id)initwithIconSheetDelegate:(id<AWActionSheetIpadDelegate>)delegate ItemCount:(int)cout
{
    int rowCount = 3;
    if (cout <=3) {
        rowCount = 1;
    } else if (cout <=6) {
        rowCount = 2;
    }
    NSString* titleBlank = @"\n\n\n\n\n\n";
    for (int i = 1 ; i<rowCount; i++) {
        titleBlank = [NSString stringWithFormat:@"%@%@",titleBlank,@"\n\n\n\n\n\n"];
    }
    if (self) {
        IconDelegate = delegate;
        self.items = [[[NSMutableArray alloc] initWithCapacity:cout] autorelease];
        [self reloadData];
    }
    
    return self;
}
- (void)reloadData
{
    for (AWActionSheetIpadCell* cell in items) {
        [cell removeFromSuperview];
        [items removeObject:cell];
    }
    
    //    if (!IconDelegate) {
    //        return;
    //    }
    
    int count = [IconDelegate numberOfItemsInActionSheet];
    
    if (count <= 0) {
        return;
    }
    
    int rowCount = 3;

    [scrollView setFrame:CGRectMake(0, 10, 320, 320)];
    [scrollView setContentSize:CGSizeMake(320*(count/itemPerPage+1), scrollView.frame.size.height)];
    [pageControl setNumberOfPages:count/itemPerPage+1];
    [pageControl setCurrentPage:0];
    
    
    for (int i = 0; i< count; i++) {
        AWActionSheetIpadCell* cell = [IconDelegate cellForViewAtIndex:i];
        int PageNo = i/itemPerPage;
        //        NSLog(@"page %d",PageNo);
        int index  = i%itemPerPage;
        
        if (itemPerPage == 9) {
            
            int row = index/3;
            int column = index%3;
            
            
            float centerY = (1+row*2)*self.scrollView.frame.size.height/(2*rowCount);
            float centerX = (1+column*2)*self.scrollView.frame.size.width/6;
            
            //            NSLog(@"%f %f",centerX+320*PageNo,centerY);
            
            [cell setCenter:CGPointMake(centerX+320*PageNo, centerY)];
            [self.scrollView addSubview:cell];
            
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionForItem:)];
            [cell addGestureRecognizer:tap];
            [tap release];
            
            //            [cell.iconView addTarget:self action:@selector(actionForItem:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        [items addObject:cell];
    }
    
}

- (void)actionForItem:(UITapGestureRecognizer*)recongizer
{
    AWActionSheetIpadCell* cell = (AWActionSheetIpadCell*)[recongizer view];
    [IconDelegate DidTapOnItemAtIndex:cell.index actionType:cell.actionType];
}
- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
    [scrollView setContentOffset:CGPointMake(320 * page, 0)];
}
#pragma mark -
#pragma scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    int page = scrollView.contentOffset.x /320;
    pageControl.currentPage = page;
}


@end

#pragma mark - AWActionSheetIpadCell
@interface AWActionSheetIpadCell ()
@end
@implementation AWActionSheetIpadCell
@synthesize iconView;
@synthesize titleLabel;

- (void)dealloc
{
    [iconView release];
    [titleLabel release];
    
    [super dealloc];
}

-(id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 70, 70)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.iconView = [[[UIImageView alloc] initWithFrame:CGRectMake(6.5, 0, 57, 57)] autorelease];
        [iconView setBackgroundColor:[UIColor clearColor]];
        [[iconView layer] setCornerRadius:8.0f];
        [[iconView layer] setMasksToBounds:YES];
        
        [self addSubview:iconView];
        
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 63, 70, 13)] autorelease];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextAlignment:UITextAlignmentCenter];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [titleLabel setTextColor:[UIColor blackColor]];
        [titleLabel setText:@""];
        [self addSubview:titleLabel];
    }
    return self;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
