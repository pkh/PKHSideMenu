# PKHSideMenu

The simple option for creating a 'slide-aside' navigation menu in your iOS apps.

## Why

There are many, many permutations of this kind of control available, on [Cocoa Controls][cocoacontrols] and elsewhere. I've used several, but haven't really liked any. So I wrote my own!

The intention is to be as simple as possible, and include just a very basic set of core features.

## How

### Setup

There are two ways to get started. You can simply add the four PKHSideMenu files to your project, or you can add PKHSideMenu as a [git submodule][submodule].

Then, you want to create your controller, most likely in your project app delegate's `application:didFinishLaunchingWithOptions:` method. First, create a menu view controller, the tableview that will be visible when your primary view slides aside. 

```objective-c
YourMenuViewController *menuViewController = [[YourMenuViewController alloc] init];
```

Then create your primary content view controller, the main content view for your application, and place inside a navigation controller, if needed.

```objective-c
YourPrimaryViewController = *primaryViewController = [[YourPrimaryViewController alloc] init];
UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:primaryViewController];
```

Then, instantiate your PKHSideMenu object and pass it your two view controllers:

```objective-c
PKHSideMenu *sideMenu = [[PKHSideMenu alloc] initWithContentViewController:navController andMenuViewController:menuViewController];
```

Now, set it as your window's root view controller and you're ready to go!

```objective-c
self.window.rootViewController = sideMenu;
```

### Management

In your related view controllers, make sure you import the `PKHSideMenu.h` file.

From within your content view controllers, you can define a navigation bar button (or other button action), to open/close the side menu like so:

```objective-c
- (void)showMenu {
		if (!self.sideMenuViewController.menuVisible) {
				[self.sideMenuViewController presentMenuViewController];
		} else {
				[self.sideMenuViewController hideMenuViewController];
		}
}
```

Due to the UIViewController category, your view controllers now have a `sideMenuViewController` property you can access. There's also a pan (or swipe) gesture that will automatically be enabled in your view controllers to open/close the side menu. 

**During setup**, there are two properties you can access on your PKHSideMenu object that can be useful if you want to modify the default behavior. The pan (or swipe) gesture is enabled by default, but you can disable it like so:

```objective-c
sideMenu.panGestureEnabled = NO;
```

And you can also change how far your primary content view controller slides aside to show your menu. You do this by modifying a property on PKHSideMenu, `contentSlidePercentage`, to specify a percentage of the primary view you want to remain on the screen. The default is 30%, which is defined as: `0.3f`. For example, if you wanted your slid-aside primary content view to cover half the horizontal width of the screen, you'd set this property like:

```objective-c
sideMenu.contentSlidePercentage = 0.5f;
```

## Notes

Though my implementation lacks much of the eye-candy of his version, much of the guidance for the basic mechanics on this kind of control came from Roman Efimov's [RESideMenu][roman].

## License

The MIT License (MIT)

Copyright (c) 2014 Patrick Hanlon

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


[cocoacontrols]:https://www.cocoacontrols.com
[submodule]:http://git-scm.com/docs/git-submodule
[roman]:https://github.com/romaonthego/RESideMenu