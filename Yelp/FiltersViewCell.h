//
//  FiltersViewCell.h
//  Yelp
//
//  Created by Oksana Timonin on 26/10/2014.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FiltersViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISwitch *switchView;

@end

@protocol FiltersViewCellProtocoll <NSObject>

- (void)didSwitch:(FiltersViewCell *)cell;

@end