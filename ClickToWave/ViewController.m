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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    Wave *w = [[Wave alloc] initWithTip:CGPointMake(0, 5)
                               andColor:[UIColor yellowColor]];
    self.wavesView.waves = @[w];
}

@end
