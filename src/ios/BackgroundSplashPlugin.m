#import "BackgroundSplashPlugin.h"

static UIImageView *imageView;

@implementation BackgroundSplashPlugin

- (void)pluginInitialize
{
 // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
 //                                              name:UIApplicationDidBecomeActiveNotification object:nil];

 // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
  //                                             name:UIApplicationWillResignActiveNotification object:nil];
}



-(void) handleBackgroundViewMode:(BOOL) active {
    
    
    // a app entrou em foreground , retirar a bacground controller
    if ( active) {
        
        if ( self.backgroundModeView != nil) {
            
            [self.backgroundModeView removeFromSuperview];
            self.backgroundModeView = nil;
            
        }
        
    }
    else {
        // passou pra background , por o background a mostrar
        
        self.backgroundModeView = [[UIView alloc ] initWithFrame:self.navigationController.topViewController.view.frame];
        self.backgroundModeView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        
        UIImageView *imgView = nil;
        UIImage *backgroundImage = nil;
        
        if ( ISIPHONE ) {
            
            CGSize dimensaoEcran = [[UIScreen mainScreen] bounds].size;
            
            backgroundImage = [UIImage imageNamed:@"Default"];
            imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, dimensaoEcran.width, dimensaoEcran.height)];
            
        }
        else {
            
            UIInterfaceOrientation uiOrientation = [[UIApplication sharedApplication] statusBarOrientation];
            switch ( uiOrientation ) {
                    
                case UIInterfaceOrientationPortrait:
                case UIInterfaceOrientationPortraitUpsideDown:
                    
                    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
                    backgroundImage = [UIImage imageNamed:@"Default-Portrait~ipad"];
                    break;
                    
                case UIInterfaceOrientationLandscapeRight:
                case UIInterfaceOrientationLandscapeLeft:
                    
                    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
                    backgroundImage = [UIImage imageNamed:@"Default-Landscape~ipad.png"];
                    break;
                    
                default:
                    NSLog(@"handleBackgroundViewMode uiinterfaceOrientation not handled: %ld", (long)uiOrientation);
                    
            }
        }
        imgView.image = backgroundImage;
        
        [self.backgroundModeView addSubview:imgView];
        
        [self.navigationController.topViewController.view addSubview:self.backgroundModeView];
        
        
    }
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [self handleBackgroundViewMode:NO];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
   
    [self handleBackgroundViewMode:YES];
    
}

@end