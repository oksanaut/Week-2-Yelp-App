//
//  FiltersViewController.h
//  Yelp
//
//  Created by Oksana Timonin on 23/10/2014.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FiltersViewController;

@protocol FiltersViewControllerDelegate <NSObject>

- (void)filtersViewController:(FiltersViewController *)filtersViewController didChangeFilters:(NSDictionary *)filters;
@end

@interface FiltersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (readonly, nonatomic) NSDictionary *filters;
@property (nonatomic, weak) id<FiltersViewControllerDelegate> delegate;

- (void)setAppliedFilters:(NSMutableDictionary *)filters;

@end

