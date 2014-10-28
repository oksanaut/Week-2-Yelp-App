//
//  Business.h
//  Yelp
//
//  Created by Oksana Timonin on 27/10/2014.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Business : NSObject

@property (nonatomic, strong) NSString *posterUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ratingUrl;
@property (nonatomic, assign) NSInteger reviewsCount;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *categories;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, strong) NSString *expenseRating;

+ (NSArray *)businessesWithDictionaries:(NSArray *)dictionaries;

@end
