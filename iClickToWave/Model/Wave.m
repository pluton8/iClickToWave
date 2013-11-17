//
//  Wave.m
//  ClickToWave
//
//  Created by u on 2013-11-17.
//  Copyright (c) 2013 yes. All rights reserved.
//

#import "Wave.h"

@implementation Wave

#pragma mark - Init

- (id)initWithTip:(CGPoint)tip andColor:(UIColor *)color {
    self = [super init];
    if (self) {
        _tip = tip;
        _color = color;
    }
    return self;
}

- (id)init {
    @throw [NSException exceptionWithName:@"Invalid initializer"
                                   reason:@"Please use the initWithTip:andColor: initializer"
                                 userInfo:nil];
}

#pragma mark - Overridden Methods

- (NSString *)description {
    return [NSString stringWithFormat:@"Wave: tip %@, color %@",
            NSStringFromCGPoint(self.tip), self.color];
}

@end
