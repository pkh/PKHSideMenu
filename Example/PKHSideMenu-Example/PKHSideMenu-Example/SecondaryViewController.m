//
//  SecondaryViewController.m
//  PKHSideMenu-Example
//
//  Created by Patrick Hanlon on 2/1/14.
//  Copyright (c) 2014 Patrick Hanlon. All rights reserved.
//

#import "SecondaryViewController.h"

@interface SecondaryViewController ()

@end

@implementation SecondaryViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor purpleColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Secondary";
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
