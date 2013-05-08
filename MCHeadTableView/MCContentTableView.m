//
//  MCContentTableView.m
//  MCemo
//  
//  Created by Vic Zhou on 5/8/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "MCContentTableView.h"
#import "MCHeadTableView.h"

static NSString *const keyPath = @"contentOffset";

@interface MCContentTableView ()

@property (nonatomic, strong) MCHeadTableView *containerView;

@end

@implementation MCContentTableView

- (id)initWithFrame:(CGRect)frame withContainerView:(UIView*)containerView
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.containerView = (MCHeadTableView*)containerView;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addObserver:self.containerView forKeyPath:keyPath
                               options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
                               context:NULL];
    }
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:keyPath ];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    [self.containerView MCScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    [self.containerView MCScrollViewDidEndDecelerating:scrollView];
}

@end
