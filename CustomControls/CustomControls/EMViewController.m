//
//  EMViewController.m
//  CustomControls
//
//  Created by Eric McConkie on 8/1/13.
//  Copyright (c) 2013 customcontrols. All rights reserved.
//

#import "EMViewController.h"
#import "EMSwitch.h"
#import "EMSegmentControll.h"
#import "UIImage+EM.h"
@interface EMViewController ()

@end

@implementation EMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self maskImage];
    [self createSwitches];
    [self createSegmentControl];
    [self createTextFields];
    [self resizeableButton];
    
    
}


#pragma mark -------------->>image mask
-(void)maskImage
{
    UIImage *sample = [UIImage imageNamed:@"missingImage"];    
    UIImage *masked = [sample maskImageWithMask:[UIImage imageNamed:@"mission_mask"]];
    UIImageView *iv = [[UIImageView alloc] initWithImage:masked];
    [self.view addSubview:iv];
}

#pragma mark -------------->>button
-(void)resizeableButton
{
    UIImage *resizableButton = [[UIImage imageNamed:@"resizableBlueButton" ] resizableImageWithCapInsets:UIEdgeInsetsMake(17, 5, 17, 5)];
    UIImage *resizableButtonHighlighted = [[UIImage imageNamed:@"resizableBlueButton" ] resizableImageWithCapInsets:UIEdgeInsetsMake(17, 5, 17, 5)];
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt setFrame:CGRectMake(20, 300, 125,42)];
    [bt setBackgroundImage:resizableButton forState:UIControlStateNormal];
    [bt setBackgroundImage:resizableButtonHighlighted forState:UIControlStateHighlighted];
    [bt setTitle:@"Test Button" forState:UIControlStateNormal];
    [bt.titleLabel setFont:[UIFont fontWithName:@"Dosis-Regular" size:12]];
    [self.view addSubview:bt];
}



#pragma mark -------------->>switches
-(void)createSwitches
{
    
    EMSwitch *switcheroo = [[EMSwitch alloc] initWithFrame:CGRectMake(20, 20, 0,0)];
    [switcheroo addTarget:self action:@selector(onswitch:) forControlEvents:UIControlEventValueChanged];
    
    
    EMSwitch *switcheroo2 = [[EMSwitch alloc] initWithFrame:CGRectMake(120, 20, 0,0)];
    [switcheroo2 addTarget:self action:@selector(onswitch:) forControlEvents:UIControlEventValueChanged];
    [switcheroo2 setTrackImage:[UIImage imageNamed:@"skinny"]];
    
    //    UIImage *shortTrackImage = [UIImage imageNamed:@"short"];
    //    EMSwitch *shorter = [[EMSwitch alloc] initWithFrame:CGRectMake(20, 100, 49,shortTrackImage.size.height)];
    //    [shorter addTarget:self action:@selector(onswitch:) forControlEvents:UIControlEventValueChanged];
    //    [shorter setTrackImage:shortTrackImage];
    
    [self.view addSubview:switcheroo];
    [self.view addSubview:switcheroo2];
    //    [self.view addSubview:shorter];
}
-(void)onswitch:(EMSwitch*)sender
{
    NSLog(@"sender\r\n---> %@",sender);
    NSLog(@"sender is on?\r\n---> %d",sender.isOn);
}


#pragma mark -
#pragma mark segment
-(void)createSegmentControl{
    NSArray *items = @[@"first", @"second", @"third"];
    EMSegmentControll *mySegmentedControl = [[EMSegmentControll alloc] initWithItems:items];
    mySegmentedControl.frame = CGRectMake(20, 240, self.view.frame.size.width - 20, mySegmentedControl.frame.size.height);
    mySegmentedControl.selectedSegmentIndex = 0;
    

    [self.view addSubview:mySegmentedControl];
}
#pragma mark -------------->>textfields
-(void)createTextFields
{
    //confirm our font works
    NSLog(@"FileName = Dosis-Medium. Font : %@", [UIFont fontNamesForFamilyName:@"Dosis"] );
    NSLog(@"FileName = OpenSans. Font : %@", [UIFont fontNamesForFamilyName:@"Open Sans"] );
    UIImage *tfOff = [UIImage imageNamed:@"input_offstate"];
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - tfOff.size.width/2, 70, tfOff.size.width, tfOff.size.height)];
    [tf setPlaceholder:@"Type some text..."];
    [tf setTag:999];
    [tf setDelegate:self];
    [tf setBorderStyle:UITextBorderStyleNone];
    [tf setBackground:tfOff];
    [tf setTextAlignment:NSTextAlignmentCenter];
    [tf setFont:[UIFont fontWithName:@"Dosis-Medium" size:23.0]];
    [tf setReturnKeyType:UIReturnKeyDone];
    tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:tf];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField setBackground:[UIImage imageNamed:@"input_onstate"]];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField setBackground:[UIImage imageNamed:@"input_offstate"]];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
