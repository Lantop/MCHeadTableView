//
//  MCContentTableView.h
//  MCemo
//
//  Created by Vic Zhou on 5/8/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCContentTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

- (id)initWithFrame:(CGRect)frame withContainerView:(UIView*)containerView;

@end
