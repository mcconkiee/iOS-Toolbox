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
    
    EMSwitch *switcheroo = [[EMSwitch alloc] initWithFrame:CGRectMake(20, 20, 85, 27)];
    [switcheroo addTarget:self action:@selector(onswitch:) forControlEvents:UIControlEventValueChanged];
    
    EMSwitch *switcheroo2 = [[EMSwitch alloc] initWithFrame:CGRectMake(20, 60, 85, 27)];
    [switcheroo2 addTarget:self action:@selector(onswitch:) forControlEvents:UIControlEventValueChanged];
    [switcheroo2 setSliderImage:[UIImage imageNamed:@"skinny"]];
    
    [self.view addSubview:switcheroo];
    [self.view addSubview:switcheroo2];
}
-(void)onswitch:(EMSwitch*)sender
{
    NSLog(@"sender\r\n---> %@",sender);
    NSLog(@"sender is on?\r\n---> %d",sender.isOn);
}
@end
