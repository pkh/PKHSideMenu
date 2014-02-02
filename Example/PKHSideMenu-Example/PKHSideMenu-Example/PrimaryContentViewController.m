//
//  PrimaryContentViewController.m
//  PKHSideMenu-Example
//
//  Created by Patrick Hanlon on 2/1/14.
//  Copyright (c) 2014 Patrick Hanlon. All rights reserved.
//

#import "PrimaryContentViewController.h"

@interface PrimaryContentViewController ()

@end

@implementation PrimaryContentViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Primary";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(showMenu)];
}

- (void)showMenu
{
    if (!self.sideMenuViewController.menuVisible) {
        [self.sideMenuViewController presentMenuViewController];
    } else {
        [self.sideMenuViewController hideMenuViewController];
    }
}

@end
