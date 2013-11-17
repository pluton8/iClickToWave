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

@property (strong, nonatomic) NSArray *waves;
@property (weak, nonatomic) NSTimer *redrawTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Wave *w = [[Wave alloc] initWithTip:CGPointMake(1, 5)
                               andColor:[UIColor yellowColor]];
    Wave *w2 = [[Wave alloc] initWithTip:CGPointMake(0, 3)
                                andColor:[UIColor greenColor]];
    self.waves = @[w, w2];
    self.wavesView.waves = self.waves;
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

#pragma mark - Timer

- (void)redrawTimerTick:(NSTimer *)timer {
    for (Wave *wave in self.waves) {
        CGPoint tip = wave.tip;
        ++tip.x;
        wave.tip = tip;
    }

    self.wavesView.waves = self.waves;
}

@end
