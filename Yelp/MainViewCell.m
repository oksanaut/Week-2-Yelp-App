//
//  MainViewCell.m
//  Yelp
//
//  Created by Oksana Timonin on 23/10/2014.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface MainViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *ratingCount;
@property (weak, nonatomic) IBOutlet UILabel *expenseLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;

@end

@implementation MainViewCell

- (void)awakeFromNib {
    // Initialization code
    self.posterView.layer.cornerRadius = 8.0;
    self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width;
}

- (void)setBusiness:(Business *)business {
    _business = business;
    [self.posterView setImageWithURL:[NSURL URLWithString:self.business.posterUrl]];
    [self.ratingView setImageWithURL:[NSURL URLWithString:self.business.ratingUrl]];
    self.nameLabel.text = self.business.name;
    self.distanceLabel.text = [NSString stringWithFormat:@"%0.2f%@", self.business.distance, @"mi"];
    self.ratingCount.text = [NSString stringWithFormat:@"%ld %@%@", (long)self.business.reviewsCount, @"Review", (self.business.reviewsCount == 1 ? @"" : @"s")];
    self.expenseLabel.text = self.business.expenseRating;
    self.addressLabel.text = self.business.address;
    self.categoriesLabel.text = self.business.categories;
}


@end
