//
//  MenuViewController.m
//  PKHSideMenu-Example
//
//  Created by Patrick Hanlon on 2/1/14.
//  Copyright (c) 2014 Patrick Hanlon. All rights reserved.
//

#import "MenuViewController.h"
#import "PrimaryContentViewController.h"
#import "SecondaryViewController.h"


@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;

@end

@implementation MenuViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = self.view.bounds;
    [closeButton addTarget:self action:@selector(closeMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
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

- (void)viewDidLayoutSubviews {
    self.tableView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y+20, self.view.bounds.size.width, self.view.bounds.size.height);
    
}


#pragma mark -

- (void)closeMenu
{
    [self.sideMenuViewController hideMenuViewController];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Home";
            break;
        case 1:
            cell.textLabel.text = @"Secondary";
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0: {   // HOME/PRIMARY
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[[PrimaryContentViewController alloc] init]];
            self.sideMenuViewController.contentViewController = navController;
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
        case 1: {   // SECONDARY
            SecondaryViewController *secondaryVC = [[SecondaryViewController alloc] init];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:secondaryVC];
            [self.sideMenuViewController setContentViewController:navController];
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
        default:
            break;
    }
}


@end
