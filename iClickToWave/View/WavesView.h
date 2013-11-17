//
//  WavesView.h
//  ClickToWave
//
//  Created by u on 2013-11-16.
//  Copyright (c) 2013 yes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WavesView : UIView

/// The number of rows and columns of the grid.
@property (assign, nonatomic) CGSize gridSize;
/// An array of waves to display. Must contain Wave objects.
@property (copy, nonatomic) NSArray *waves;

/// The block is invoked when a cell in this view is clicked.
@property (copy, nonatomic) void(^cellClickBlock)(WavesView *view, CGPoint cell);

@end
