//
//  WavesView.m
//  ClickToWave
//
//  Created by u on 2013-11-16.
//  Copyright (c) 2013 yes. All rights reserved.
//

#import "WavesView.h"
#import "Wave.h"

@interface WavesView ()

@property (weak, nonatomic) UITapGestureRecognizer *tapRecognizer;

@end

@implementation WavesView

#pragma mark - Init

- (void)dealloc {
    if (self.tapRecognizer) {
        [self removeGestureRecognizer:self.tapRecognizer];
        self.tapRecognizer = nil;
    }
}

- (void)baseInit {
    _gridSize = CGSizeMake(10, 8);

    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(handleTap:)];
    _tapRecognizer = tapRec;
    [self addGestureRecognizer:_tapRecognizer];
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

/// Builds a path for the wave. It includes the rect for the tip, another higher
/// rect to the left, and so on.
- (void)buildPathForWaveWithTip:(CGPoint)tip inCGContext:(CGContextRef)ctx {
    CGFloat xStep = self.bounds.size.width / self.gridSize.width;
    CGFloat yStep = self.bounds.size.height / self.gridSize.height;

    int height = 1;
    int y = tip.y;
    for (int x = tip.x; x >= 0; --x) {
        CGContextAddRect(ctx,
                         CGRectMake(xStep * x, yStep * y, xStep, yStep * height));
        --y;
        height += 2;
    }
}

/// Returns the cell coordinates under the given point on screen.
- (CGPoint)cellAtPoint:(CGPoint)point {
    CGFloat xStep = self.bounds.size.width / self.gridSize.width;
    CGFloat yStep = self.bounds.size.height / self.gridSize.height;
    return CGPointMake(floorf(point.x / xStep), floorf(point.y / yStep));
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

        [self buildPathForWaveWithTip:wave.tip inCGContext:ctx];
        CGContextFillPath(ctx);
    }
}

- (void)drawGrid:(CGSize)size {
    CGRect bounds = self.bounds;
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextSaveGState(ctx);

    CGContextSetLineWidth(ctx, 1.0);
    [[UIColor lightGrayColor] setStroke];

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

#pragma mark - Gesture Recognizers

- (void)handleTap:(UITapGestureRecognizer *)sender {
    if (UIGestureRecognizerStateEnded == sender.state) {
        CGPoint tapPoint = [sender locationInView:self];
        if (self.cellClickBlock) {
            self.cellClickBlock(self, [self cellAtPoint:tapPoint]);
        }
    }
}

@end
