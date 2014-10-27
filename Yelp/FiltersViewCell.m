//
//  FiltersViewCell.m
//  Yelp
//
//  Created by Oksana Timonin on 26/10/2014.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FiltersViewCell.h"

@implementation FiltersViewCell
@synthesize delegate;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)onValueChange:(id)sender {
    
}

@end
