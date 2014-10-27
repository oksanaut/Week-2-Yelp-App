//
//  Filterset.m
//  Yelp
//
//  Created by Oksana Timonin on 24/10/2014.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "Filterset.h"

@implementation Filterset

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.label = dictionary[@"display_name"];
        self.type = dictionary[@"type"];
        self.options = dictionary[@"optons"];
    }
    return self;
}

+ (NSArray *)filtersDictionaries:(NSArray *)dictionaries {
    NSMutableArray *filtersets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Filterset *filterset = [[Filterset alloc] initWithDictionary:dictionary];
        [filtersets addObject:filterset];
        
    }
    return filtersets;
}

@end
