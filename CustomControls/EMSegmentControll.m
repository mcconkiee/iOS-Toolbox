//
//  EMSegmentControll.m
//  CustomControls
//
//  Created by Eric McConkie on 8/7/13.
//  Copyright (c) 2013 customcontrols. All rights reserved.
//

#import "EMSegmentControll.h"

@implementation EMSegmentControll

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithItems:(NSArray *)items {
    self = [super initWithItems:items];
    if (self) {
        // Initialization code
        
        // Set divider images
        [self setDividerImage:[UIImage imageNamed:@"seg-divider-none-selected"]
          forLeftSegmentState:UIControlStateNormal
            rightSegmentState:UIControlStateNormal
                   barMetrics:UIBarMetricsDefault];
        [self setDividerImage:[UIImage imageNamed:@"seg-divider-left-selected"]
          forLeftSegmentState:UIControlStateSelected
            rightSegmentState:UIControlStateNormal
                   barMetrics:UIBarMetricsDefault];
        [self setDividerImage:[UIImage imageNamed:@"seg-divider-right-selected"]
          forLeftSegmentState:UIControlStateNormal
            rightSegmentState:UIControlStateSelected
                   barMetrics:UIBarMetricsDefault];
        
        // Set background images
        UIImage *normalBackgroundImage = [UIImage imageNamed:@"seg-unselected"];
        [self setBackgroundImage:normalBackgroundImage
                        forState:UIControlStateNormal
                      barMetrics:UIBarMetricsDefault];
        UIImage *selectedBackgroundImage = [UIImage imageNamed:@"seg-selected"];
        [self setBackgroundImage:selectedBackgroundImage
                        forState:UIControlStateSelected
                      barMetrics:UIBarMetricsDefault];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
