//
//  Filterset.h
//  Yelp
//
//  Created by Oksana Timonin on 24/10/2014.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filterset : NSObject

@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSArray *options;

@end
