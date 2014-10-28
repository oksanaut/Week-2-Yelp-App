//
//  FiltersViewCell.m
//  Yelp
//
//  Created by Oksana Timonin on 27/10/2014.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FiltersViewCell.h"
@interface FiltersViewCell ()
@property (weak, nonatomic) IBOutlet UISwitch *toggle;

- (IBAction)valueDidChange:(id)sender;

@end

@implementation FiltersViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setOn:(BOOL)on {
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    _on = on;
    [self.toggle setOn:on animated:animated];
}

- (IBAction)valueDidChange:(id)sender {
    [self.delegate filtersViewCell:self didUpdate:self.toggle.on];
}

@end
