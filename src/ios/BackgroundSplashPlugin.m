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
    
    
    
    // app entered foreground , remove background controller
    if ( active) {
        
        if (imageView == NULL) {
            self.viewController.view.window.hidden = NO;
        } else {
            [imageView removeFromSuperview];
        }
        
    }
    else {

        CDVViewController *vc = (CDVViewController*)self.viewController;
        NSString* imageName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UILaunchImageFile"];

        if (imageName) {
            imageName = [imageName stringByDeletingPathExtension];
        } else {
            imageName = @"Default";
        }


        UIImage *splash = [UIImage imageNamed:imageName];
        if (splash == NULL) {
            imageView = NULL;
            self.viewController.view.window.hidden = YES;
        } else {
            imageView = [[UIImageView alloc]initWithFrame:[self.viewController.view bounds]];
            [imageView setImage:splash];
    
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