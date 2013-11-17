//
//  ViewController.m
//  ClickToWave
//
//  Created by u on 2013-11-16.
//  Copyright (c) 2013 yes. All rights reserved.
//

#import "ViewController.h"
#import "Wave.h"
#import "WavesView.h"

/// Waves speed in number of movements per second.
static const int kWaveSpeed = 8;

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *waves;
@property (weak, nonatomic) NSTimer *redrawTimer;

@end

@implementation ViewController

#pragma mark - Init

- (void)baseInit {
    _waves = [@[] mutableCopy];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self) wself = self;
    self.wavesView.cellClickBlock = ^(WavesView *view, CGPoint cell) {
        Wave *newWave = [[Wave alloc] initWithTip:CGPointMake(0, cell.y)
                                         andColor:[self randomColor]];
        typeof(self) sself = wself;
        [sself.waves addObject:newWave];
        sself.wavesView.waves = sself.waves;
    };
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (self.redrawTimer) {
        [self.redrawTimer invalidate];
    }

    self.redrawTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / kWaveSpeed)
                                                        target:self
                                                      selector:@selector(redrawTimerTick:)
                                                      userInfo:nil
                                                       repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.redrawTimer invalidate];
    self.redrawTimer = nil;
}

#pragma mark - Private Methods

- (UIColor *)randomColor {
    static NSArray *colors = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colors = @[[UIColor yellowColor],
                   [UIColor greenColor],
                   [UIColor redColor],
                   [UIColor orangeColor],
                   [UIColor purpleColor],
                   [UIColor magentaColor],
                   [UIColor cyanColor],
                   [UIColor blackColor]];
    });

    return colors[arc4random() % colors.count];
}

#pragma mark - Timer

- (void)redrawTimerTick:(NSTimer *)timer {
    if (self.waves.count <= 0) {
        // nothing to do yet
        return;
    }

    for (Wave *wave in self.waves) {
        CGPoint tip = wave.tip;
        ++tip.x;
        wave.tip = tip;
    }

    self.wavesView.waves = self.waves;
}

@end
