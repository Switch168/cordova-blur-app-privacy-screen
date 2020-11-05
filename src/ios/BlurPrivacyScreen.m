#import "AppDelegate.h"

@interface AppDelegate (BlurAppPrivacyScreen) {}
@end

@implementation AppDelegate (BlurAppPrivacyScreen)

BOOL init;
UIView *blurView;
UIBlurEffect *blurEffect;
UIVisualEffectView *blurEffectView;


- (void)applicationWillResignActive:(UIApplication *)application {
    self.window.backgroundColor = [UIColor clearColor];

    if(!init) {
        blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.window.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        init = true;
    }

    blurEffectView.tag = 1234;
    blurEffectView.alpha = 1;
    [self.window addSubview:blurEffectView];
    [self.window bringSubviewToFront:blurEffectView];

    // fade in the view
    [UIView animateWithDuration:1.5 animations:^{
        blurEffectView.alpha = 1;
    } completion:^(BOOL finished) {
        [self.window bringSubviewToFront:blurEffectView];
    }];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    blurEffectView = [self.window viewWithTag:1234];
    [self.window bringSubviewToFront:blurEffectView];

    // fade away colour view from main view
    [UIView animateWithDuration:1.5 animations:^{
        blurEffectView.alpha = 0;
    } completion:^(BOOL finished) {
        // remove when finished fading
        [self.window sendSubviewToBack:blurEffectView];
        blurEffectView.alpha = 1;
    }];
}

@end
