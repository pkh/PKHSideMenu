//
// PKHSideMenu.m
// PKHSideMenu
//
// Copyright (c) 2014 Patrick Hanlon
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "PKHSideMenu.h"

@interface PKHSideMenu ()

@property (assign, readwrite, nonatomic) CGPoint originalPoint;

@end

@implementation PKHSideMenu

- (instancetype)init
{
    if (self = [super init]) {
        [self generalInit];
    }
    return self;
}

- (instancetype)initWithContentViewController:(UIViewController *)contentVC andMenuViewController:(UIViewController *)menuVC
{
    self = [self init];
    if (self) {
        _contentViewController = contentVC;
        _menuViewController = menuVC;
    }
    return self;
}

- (void)generalInit
{
    
    _animationDuration = 0.25f;
    _panGestureEnabled = YES;
    _contentSlidePercentage = 0.3f;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    [self setupShadowForContentViewController:self.contentViewController];
    
    // add the 2 VC's as child view controllers
    [self pkh_displayController:self.menuViewController frame:self.view.bounds];
    [self pkh_displayController:self.contentViewController frame:self.view.bounds];
    
    if (self.panGestureEnabled) {
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
        panGesture.delegate = self;
        [self.view addGestureRecognizer:panGesture];
    }
    
}

#pragma mark - Set Content View Shadow

- (void)setupShadowForContentViewController:(UIViewController *)controller
{
    controller.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    controller.view.layer.shadowOpacity = 1.0f;
    controller.view.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.contentViewController.view.bounds] CGPath];
    controller.view.layer.shadowOffset = CGSizeZero;
    controller.view.layer.shadowRadius = 5.0f;
}

#pragma mark - Content View Management

- (void)setContentViewController:(UIViewController *)contentViewController
{
    
    if (!_contentViewController) {
        _contentViewController = contentViewController;
        return;
    } else {
        [self pkh_hideController:_contentViewController];
    }
    
    CGRect frame = _contentViewController.view.frame;
    _contentViewController = contentViewController;
    
    [self setupShadowForContentViewController:contentViewController];
    
    [self pkh_displayController:contentViewController frame:self.view.bounds];
    contentViewController.view.frame = frame;
    
}

#pragma mark - Hiding/Showing Menu View Controller

- (void)presentMenuViewController
{
    
    self.menuVisible = YES;
    
    [UIView animateWithDuration:self.animationDuration animations:^(){
        CGFloat origCenterXCoord = CGRectGetWidth(self.contentViewController.view.bounds) / 2.0;
        CGFloat origCenterYCoord = CGRectGetHeight(self.contentViewController.view.bounds) / 2.0;
        
        CGFloat contentViewWidth = self.contentViewController.view.frame.size.width;
        CGFloat slideDistance = contentViewWidth - (contentViewWidth * self.contentSlidePercentage);
        
        CGFloat newXCoord = (origCenterXCoord + slideDistance);
        
        self.contentViewController.view.center = CGPointMake(newXCoord, origCenterYCoord);
    }];
}

- (void)hideMenuViewController
{
    self.menuVisible = NO;
    
    [UIView animateWithDuration:self.animationDuration animations:^(){
        CGFloat origXCoord = self.contentViewController.view.frame.size.width/2;
        CGFloat origYCoord = self.contentViewController.view.center.y;
        self.contentViewController.view.center = CGPointMake(origXCoord, origYCoord);
    }];
}

#pragma mark - Gesture Recognizers

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)recognizer{
    
    CGPoint translationPoint = [recognizer translationInView:self.view];
    CGPoint velocity = [recognizer velocityInView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.originalPoint = CGPointMake(self.contentViewController.view.center.x, self.contentViewController.view.center.y);
    }
    
    if (recognizer.state == UIGestureRecognizerStateBegan || recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGFloat newCenterXCoord = self.contentViewController.view.center.x + translationPoint.x;
        CGFloat leftEdgeCoord = newCenterXCoord - (CGRectGetWidth(self.contentViewController.view.bounds) / 2.0);
        
        CGFloat contentViewWidth = self.contentViewController.view.frame.size.width;
        CGFloat slideDistance = contentViewWidth - (contentViewWidth * self.contentSlidePercentage);
        
        if (leftEdgeCoord > 0.0 && leftEdgeCoord <= slideDistance) {   // keep sliding, haven't hit threshold yet...
            self.contentViewController.view.center = CGPointMake(newCenterXCoord, self.contentViewController.view.center.y);
            [recognizer setTranslation:CGPointZero inView:self.view];
        } else {
            // contentSlidePercentage threshold hit
        }
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (velocity.x > 0) {
            [self presentMenuViewController];
        } else {
            [self hideMenuViewController];
        }
    }
    
}

@end    
