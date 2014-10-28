//
//  Business.m
//  Yelp
//
//  Created by Oksana Timonin on 27/10/2014.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "Business.h"

@implementation Business
- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        NSArray *categories = dictionary[@"categories"];
        NSMutableArray *categoryNames = [NSMutableArray array];
        [categories enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [categoryNames addObject:obj[0]];
        }];
        self.categories = [categoryNames componentsJoinedByString:@", "];
        self.name = dictionary[@"name"];
        self.reviewsCount = [dictionary[@"review_count"] integerValue];
        self.expenseRating = [@"" stringByPaddingToLength:arc4random_uniform(5) withString: @"$" startingAtIndex:0];
        self.posterUrl = dictionary[@"image_url"];
        self.ratingUrl = dictionary[@"rating_img_url_large"];
        NSString *street = @"";
        NSArray *addresses = [dictionary valueForKeyPath:@"location.address"];
        if (addresses.count) {
            street = [dictionary valueForKeyPath:@"location.address"][0];
        } else {
            street = [dictionary valueForKeyPath:@"location.display_address"][0];
        }
        NSString *neighborhood = [dictionary valueForKeyPath:@"location.neighborhoods"][0];
        self.address = [NSString stringWithFormat:@"%@, %@", street, neighborhood];
        self.distance = [dictionary[@"distance"] integerValue] * 0.000621371;
    }
    return self;
    
}
+ (NSArray *)businessesWithDictionaries:(NSArray *)dictionaries {
    NSMutableArray *businesses = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Business *business = [[Business alloc] initWithDictionary:dictionary];
        [businesses addObject:business];
    }
    return businesses;
}

@end
