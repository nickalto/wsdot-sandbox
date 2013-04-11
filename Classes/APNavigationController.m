//
//  APNavigationController.m
//  APExtendedPageController
//
//  Created by Nick Alto on 4/10/13.
//  Copyright (c) 2013 apuczyk. All rights reserved.
//

#import "APNavigationController.h"

@interface APNavigationController ()

@end

@implementation APNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"custom navbar\n");
        //[self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:0.094 green:0.094 blue:0.098 alpha:1.000]];
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"seatrafficheader.png"] forBarMetrics:UIBarMetricsDefault];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
