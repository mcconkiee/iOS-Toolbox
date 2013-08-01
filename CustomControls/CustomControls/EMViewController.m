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
    
    EMSwitch *switcheroo = [[EMSwitch alloc] initWithFrame:CGRectMake(0, 0, 85, 50)];
    
//    [switcheroo addTarget:self action:@selector(onswitch:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switcheroo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
