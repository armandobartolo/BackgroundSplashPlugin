#import "BackgroundSplashPlugin.h"

static UIImageView *imageView;

@implementation BackgroundSplashPlugin

- (void)pluginInitialize
{

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
                                               name:UIApplicationDidBecomeActiveNotification object:nil];

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:)
                                               name:UIApplicationDidEnterBackgroundNotification object:nil];
}



-(void) handleBackgroundViewMode:(BOOL) active {
    
    if ( active) {
        
        if (imageView == NULL) {
            self.viewController.view.window.hidden = NO;
        } else {
            [imageView removeFromSuperview];
        }
        
    }
    else {
        NSString *imageName = @"LaunchStoryboard";
  
        UIImage *splash = [UIImage imageNamed:imageName];
        if (splash == NULL) {
            imageView = NULL;
            self.viewController.view.window.hidden = YES;
        } else {
            UIScreen* mainScreen = [UIScreen mainScreen];
            CGFloat mainScreenHeight = mainScreen.bounds.size.height;
            CGFloat mainScreenWidth = mainScreen.bounds.size.width;
            
            imageView = [[UIImageView alloc]initWithFrame:[self.viewController.view bounds]];
            [imageView setImage:splash];
            [imageView setContentMode:(UIViewContentMode)UIViewContentModeScaleAspectFill];
            [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
            [imageView setFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
            
        #ifdef __CORDOVA_4_0_0
            [[UIApplication sharedApplication].keyWindow addSubview:imageView];
        #else
            [self.viewController.view addSubview:imageView];
        #endif

    }
   } 
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{

    [self handleBackgroundViewMode:NO];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
   
    [self handleBackgroundViewMode:YES];
    
}

@end
