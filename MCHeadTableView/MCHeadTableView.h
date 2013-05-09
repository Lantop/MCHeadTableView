//
//  MCHeadTableView.h
//  MCHeadTableView
//
//  Created by Vic Zhou on 5/6/13.
//  Copyright (c) 2013 Vic. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCHeadTableView;
@class MCContentTableView;

@protocol MCHeadTableViewDelegate <NSObject>

- (UIView*)MCHeadTableViewHeaderView;

- (CGFloat)MCHeadTableViewSectionViewHeight;

- (UIView*)MCHeadTableViewSectionView;

- (MCContentTableView*)MCHeadTableViewFooterView;

@end

@interface MCHeadTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <MCHeadTableViewDelegate> delegateHeader;

- (void)MCScrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate;

- (void)MCScrollViewDidEndDecelerating:(UIScrollView*)scrollView;

- (void)MCReloadData;

@end

/*
 table header view
 */

@interface tableHeaderView : UIView

@property (nonatomic, strong) UITableView *contentTableView;

@end