//
//  WavesView.m
//  ClickToWave
//
//  Created by u on 2013-11-16.
//  Copyright (c) 2013 yes. All rights reserved.
//

#import "WavesView.h"
#import "Wave.h"

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

#pragma mark - Setters & Getters

- (void)setGridSize:(CGSize)gridSize {
    _gridSize = gridSize;
    [self setNeedsDisplay];
}

- (void)setWaves:(NSArray *)waves {
    _waves = [waves copy];
    [self setNeedsDisplay];
}

#pragma mark - Private Methods

- (CGRect)rectForWaveTip:(CGPoint)tip {
    CGFloat xStep = self.bounds.size.width / self.gridSize.width;
    CGFloat yStep = self.bounds.size.height / self.gridSize.height;
    return CGRectMake(xStep * tip.x, yStep * tip.y, xStep, yStep);
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    [self drawWaves:self.waves];
    [self drawGrid:self.gridSize];
}

- (void)drawWaves:(NSArray *)waves {
    if (waves.count <= 0) {
        return;
    }

    CGContextRef ctx = UIGraphicsGetCurrentContext();

    for (Wave *wave in waves) {
        [wave.color setFill];
        CGContextFillRect(ctx, [self rectForWaveTip:wave.tip]);
    }
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
