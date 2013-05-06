//
//  MCHeadTableView.h
//  MCHeadTableView
//
//  Created by Vic Zhou on 5/6/13.
//  Copyright (c) 2013 Vic. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCHeadTableView;

@protocol MCHeadTableViewDelegate <NSObject>

- (UIView*)MCHeadTableViewHeaderView;

- (UIView*)MCHeadTableViewSectionView;

@end

@interface MCHeadTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <MCHeadTableViewDelegate> delegateHeader;

@end

/*
 table header view
 */

@interface tableHeaderView : UIView

@property (nonatomic, strong) UITableView *contentTableView;

@end