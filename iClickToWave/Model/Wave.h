//
//  Wave.h
//  ClickToWave
//
//  Created by u on 2013-11-17.
//  Copyright (c) 2013 yes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Wave : NSObject

/// The coordinates of the wave's tip. The origin is left-top corner.
@property (assign, nonatomic) CGPoint tip;
/// The color of the wave.
@property (assign, nonatomic) UIColor *color;

/// DO NOT USE this initializer.
- (id)init;

/// The designated initializer.
- (instancetype)initWithTip:(CGPoint)tip andColor:(UIColor *)color;

@end
