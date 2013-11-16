//
//  WavesView.m
//  ClickToWave
//
//  Created by u on 2013-11-16.
//  Copyright (c) 2013 yes. All rights reserved.
//

#import "WavesView.h"

@implementation WavesView

#pragma mark - Init

- (void)baseInit {
    _gridSize = CGSizeMake(10, 8);
}

- (id)init {
    self = [super init];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self baseInit];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    [self drawGrid:self.gridSize];
}

- (void)drawGrid:(CGSize)size {
    CGRect bounds = self.bounds;
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextSaveGState(ctx);

    CGContextSetLineWidth(ctx, 1.0);

    CGFloat xStep = bounds.size.width / size.width;
    for (CGFloat x = 0; x <= bounds.size.width; x += xStep) {
        CGContextMoveToPoint(ctx, x, 0);
        CGContextAddLineToPoint(ctx, x, bounds.size.height);
    }

    CGFloat yStep = bounds.size.height / size.height;
    for (CGFloat y = 0; y <= bounds.size.height; y += yStep) {
        CGContextMoveToPoint(ctx, 0, y);
        CGContextAddLineToPoint(ctx, bounds.size.width, y);
    }

    CGContextStrokePath(ctx);

    CGContextRestoreGState(ctx);
}

@end
