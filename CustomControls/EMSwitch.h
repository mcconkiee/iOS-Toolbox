//
//  EMSwitch.h
//  CustomControls
//
//  Created by Eric McConkie on 8/1/13.
//  Copyright (c) 2013 customcontrols. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EMSwitchDelegate <NSObject>

@optional
-(BOOL)emSwitchCanSwitch:(id)emSwitch;

@end

@interface EMSwitch : UIControl
@property (nonatomic)BOOL isOn;

-(void)setIsOn:(BOOL)aisOn animated:(BOOL)animated;
@property (nonatomic,weak)UIImage *trackImage;
@property (nonatomic,weak)UIImage *thumbImage;
@property (nonatomic,assign)id<EMSwitchDelegate> delegate;
@end
