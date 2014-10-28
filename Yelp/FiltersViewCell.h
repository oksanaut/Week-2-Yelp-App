//
//  FiltersViewCell.h
//  Yelp
//
//  Created by Oksana Timonin on 27/10/2014.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FiltersViewCell;

@protocol FiltersViewCellDelegate <NSObject>

- (void)filtersViewCell:(FiltersViewCell *)cell didUpdate:(BOOL)value;

@end

@interface FiltersViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;


@property (weak, nonatomic) NSString *value;
@property (weak, nonatomic) NSString *filter;

@property (nonatomic, assign) BOOL on;
@property (nonatomic, weak) id<FiltersViewCellDelegate> delegate;

- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end
