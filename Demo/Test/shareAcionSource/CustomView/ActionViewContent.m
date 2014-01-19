//
//  ActionViewContent.m
//  Test
//
//  Created by liupeng on 1/17/14.
//  Copyright (c) 2014 crte. All rights reserved.
//

#import "ActionViewContent.h"
#define itemPerPage 8

@interface ActionViewContent()<UIScrollViewDelegate>
@property (nonatomic, retain)UIScrollView* scrollView;
@property (nonatomic, retain)UIPageControl* pageControl;
@property (nonatomic, retain)NSMutableArray* items;
@property (nonatomic, assign)id<ActionViewContentDelegate> IconDelegate;
@end
@implementation ActionViewContent
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
        self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 22, 320, 80*2)] autorelease];
        [scrollView setPagingEnabled:YES];
        [scrollView setBackgroundColor:[UIColor clearColor]];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        [scrollView setDelegate:self];
        [scrollView setScrollEnabled:YES];
        [scrollView setBounces:NO];
        [self addSubview:scrollView];
        
        self.pageControl = [[[UIPageControl alloc] initWithFrame:CGRectMake(320/2, 85*2 + 22, 0, 20)] autorelease];
        [pageControl setNumberOfPages:0];
        [pageControl setCurrentPage:0];
        [pageControl addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
        [self addSubview:pageControl];
    }
    return self;
}
-(id)initwithIconSheetDelegate:(id<ActionViewContentDelegate>)delegate ItemCount:(int)cout
{
    if (self) {
        IconDelegate = delegate;
        self.items = [[[NSMutableArray alloc] initWithCapacity:cout] autorelease];
        [self reloadData];
    }
    if (cout<=itemPerPage) {
        [pageControl setHidden:YES];
    }
    return self;
}
- (void)reloadData
{
    for (ActionViewContentCell* cell in items) {
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
    
    int rowCount = 4;
    
    [scrollView setFrame:CGRectMake(0, 22, 320, 200)];
    [scrollView setContentSize:CGSizeMake(320*(count/itemPerPage+1), 200)];
    [pageControl setNumberOfPages:count/itemPerPage+1];
    [pageControl setCurrentPage:0];

    for (int i = 0; i< count; i++) {
        ActionViewContentCell* cell = [IconDelegate cellForViewAtIndex:i];
        int PageNo = i/itemPerPage;
        int index  = i%itemPerPage;
        if (itemPerPage == 8) {
            int row = index/4;
            int column = index%4;
            float centerY = (1+row*3)*self.scrollView.frame.size.height/(2*rowCount);
            float centerX = (1+column*2)*self.scrollView.frame.size.width/8;
            [cell setCenter:CGPointMake(centerX+320*PageNo, centerY+20 + (row-1)*5)];
            [self.scrollView addSubview:cell];
            
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionForItem:)];
            [cell addGestureRecognizer:tap];
            [tap release];
        }
        
        [items addObject:cell];
    }
    
}

- (void)actionForItem:(UITapGestureRecognizer*)recongizer
{
    ActionViewContentCell* cell = (ActionViewContentCell*)[recongizer view];
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
@interface ActionViewContentCell ()
@end
@implementation ActionViewContentCell
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
    self = [super initWithFrame:CGRectMake(0, 2, 65, 60)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.iconView = [[[UIImageView alloc] initWithFrame:CGRectMake(6.5, 0, 55, 55)] autorelease];
        [iconView setBackgroundColor:[UIColor clearColor]];
        [[iconView layer] setCornerRadius:9.0f];
        [[iconView layer] setMasksToBounds:YES];
        
        [self addSubview:iconView];
        
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(-2.5, 56, 70, 13)] autorelease];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextAlignment:UITextAlignmentCenter];
        [titleLabel setFont:[UIFont systemFontOfSize:10]];
        [titleLabel setTextColor:[UIColor blackColor]];
        [titleLabel setText:@""];
        [self addSubview:titleLabel];
    }
    return self;
}
@end