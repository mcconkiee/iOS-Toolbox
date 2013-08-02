//
//  EMViewController.m
//  CustomControls
//
//  Created by Eric McConkie on 8/1/13.
//  Copyright (c) 2013 customcontrols. All rights reserved.
//

#import "EMViewController.h"
#import "EMSwitch.h"
@interface EMViewController ()

@end

@implementation EMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self createSwitches];
    [self createTextFields];
    
    
}





#pragma mark -------------->>switches
-(void)createSwitches
{
    UIImage *track = [UIImage imageNamed:@"track"];
    UIImage *thumb =[UIImage imageNamed:@"thumb"];
    EMSwitch *switcheroo = [[EMSwitch alloc] initWithFrame:CGRectMake(20, 20, track.size.width/2+ thumb.size.width/2 , 31)];
    [switcheroo setTrackImage:track];
    [switcheroo setThumbImage:thumb];
    [switcheroo addTarget:self action:@selector(onswitch:) forControlEvents:UIControlEventValueChanged];
    
    
    EMSwitch *switcheroo2 = [[EMSwitch alloc] initWithFrame:CGRectMake(120, 20, 85, 30)];
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

#pragma mark -------------->>textfields
-(void)createTextFields
{
    //confirm our font works
    NSLog(@"FileName = Dosis-Medium. Font : %@", [UIFont fontNamesForFamilyName:@"Dosis"] );
    
    UIImage *tfOff = [UIImage imageNamed:@"input_offstate"];
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - tfOff.size.width/2, 70, tfOff.size.width, tfOff.size.height)];
    [tf setPlaceholder:@"Type some text..."];
    [tf setTag:999];
    [tf setDelegate:self];
    [tf setBorderStyle:UITextBorderStyleNone];
    [tf setBackground:tfOff];
    [tf setTextAlignment:NSTextAlignmentCenter];
    [tf setFont:[UIFont fontWithName:@"Dosis" size:23.0]];
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
