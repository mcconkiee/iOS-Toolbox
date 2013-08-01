//
//  EMSwitch.h
//  CustomControls
//
//  Created by Eric McConkie on 8/1/13.
//  Copyright (c) 2013 customcontrols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMSwitch : UIControl<UIGestureRecognizerDelegate>
@property (nonatomic)BOOL isOn;
@property (nonatomic,weak)UIImage *trackImage;
@property (nonatomic,weak)UIImage *thumbImage;
@end
