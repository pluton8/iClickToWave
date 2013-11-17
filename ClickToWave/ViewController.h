//
//  ViewController.h
//  ClickToWave
//
//  Created by u on 2013-11-16.
//  Copyright (c) 2013 yes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WavesView;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet WavesView *wavesView;
@property (weak, nonatomic) IBOutlet UISlider *numRowsSlider;
@property (weak, nonatomic) IBOutlet UISlider *numColumnsSlider;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;

- (IBAction)numRowsSliderDidChange:(UISlider *)sender;
- (IBAction)numColumnsSliderDidChange:(UISlider *)sender;
- (IBAction)speedSliderDidChange:(UISlider *)sender;

@end
