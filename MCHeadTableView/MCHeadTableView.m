#import "MCHeadTableView.h"
#import "MCContentTableView.h"

#define threshold 20

@interface MCHeadTableView ()

@property (nonatomic, strong) tableHeaderView *tableHeader;
@property (nonatomic, strong) UIView *tableSection;
@property (nonatomic, strong) MCContentTableView *tableviewContent;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) BOOL direction;

@end

@implementation MCHeadTableView

#pragma mark Value

- (tableHeaderView*)tableHeader {
    if (!_tableHeader) {
        _tableHeader = [[tableHeaderView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.headerHeight)];
        _tableHeader.contentTableView = self.tableviewContent;
    }
    return _tableHeader;
}

- (MCContentTableView*)tableviewContent {
    if (!_tableviewContent) {
        _tableviewContent = [[MCContentTableView alloc] initWithFrame:CGRectZero withContainerView:self];
        
    }
    return _tableviewContent;
}

#pragma mark - Set Value

- (void)setDelegateHeader:(id<MCHeadTableViewDelegate>)delegateHeader {
    _delegateHeader = delegateHeader;
}

#pragma mark - NSObject

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.headerHeight = 80.f;
    }
    return self;
}

#pragma mark - UIView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //set the header view
    if ([self.delegateHeader respondsToSelector:@selector(MCHeadTableViewHeaderView)]) {
        UIView *view = [self.delegateHeader MCHeadTableViewHeaderView];
        self.headerHeight = view.frame.size.height;
        [self.tableHeader addSubview:view];
    }
    self.tableHeaderView = self.tableHeader;
    self.tableFooterView = self.tableviewContent;
    self.dataSource = self;
    self.delegate = self;
    self.scrollEnabled = NO;
    [self MCReloadData];
}

#pragma mark - Actions Private

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    CGPoint newPoint = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
    CGPoint oldPoint = [[change valueForKey:NSKeyValueChangeOldKey] CGPointValue];
    
    if(oldPoint.y > newPoint.y)
        self.direction = YES;
    else
        self.direction = NO;
    
    if(self.contentOffset.y < self.headerHeight)
    {
        if(newPoint.y > 0)
        {
            if(self.tableviewContent.contentOffset.y != 0)
                [self.tableviewContent setContentOffset:CGPointMake(0, 0)];
            
            if(self.contentOffset.y+newPoint.y < self.headerHeight)
                [self setContentOffset:CGPointMake(0, self.contentOffset.y+newPoint.y)];
            else
                [self setContentOffset:CGPointMake(0, self.headerHeight)];
        }
    }
    
    if(self.contentOffset.y <= self.headerHeight && self.tableviewContent.contentOffset.y < 0)
    {
        if(self.contentOffset.y > 0)
        {
            if(self.tableviewContent.contentOffset.y != 0)
                [self.tableviewContent setContentOffset:CGPointMake(0, 0)];
            
            if(self.contentOffset.y+newPoint.y > 0)
                [self setContentOffset:CGPointMake(0, self.contentOffset.y+newPoint.y)];
            else
                [self setContentOffset:CGPointMake(0, 0)];
        }
    }
}

#pragma mark - Actions Public

- (void)MCScrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate)
    {
        if(self.contentOffset.y < threshold)
            [self setContentOffset:CGPointMake(0, 0) animated:YES];
        else if(self.contentOffset.y > self.headerHeight-threshold)
            [self setContentOffset:CGPointMake(0, self.headerHeight) animated:YES];
        else if(self.direction)
            [self setContentOffset:CGPointMake(0, self.headerHeight) animated:YES];
        else
            [self setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)MCScrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    if(self.direction || self.contentOffset.y == self.headerHeight)
        [self setContentOffset:CGPointMake(0, self.headerHeight) animated:YES];
    else
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
}


- (void)MCReloadData {
    if ([self.delegateHeader respondsToSelector:@selector(MCHeadTableViewFooterView)]) {
        MCContentTableView *view = [self.delegateHeader MCHeadTableViewFooterView];
        self.tableviewContent = view;
        self.tableFooterView = view;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.tableSection;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat sectionHeight = 40.f;
    if ([self.delegateHeader respondsToSelector:@selector(MCHeadTableViewSectionView)]) {
        self.tableSection = [self.delegateHeader MCHeadTableViewSectionView];
        sectionHeight = self.tableSection.frame.size.height;
        self.tableviewContent.frame = CGRectMake(0.f, 0.f, self.bounds.size.width, self.bounds.size.height-sectionHeight);
    }
    return sectionHeight;
}

@end

/*
 table header view
 */

@implementation tableHeaderView

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    return [self.contentTableView hitTest:point withEvent:event];
}

@end