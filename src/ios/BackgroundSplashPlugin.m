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

        CDVViewController *vc = (CDVViewController*)self.viewController;
     
NSString *imageName = [self getImageName: [self getCurrentDevice]];
  

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

// code borrowed from cordova-plugin-splashscreen and added the new iPhone X's sizes has on -> https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions

- (CDV_iOSDevice) getCurrentDevice
{
  CDV_iOSDevice device;
  
  UIScreen* mainScreen = [UIScreen mainScreen];
  CGFloat mainScreenHeight = mainScreen.bounds.size.height;
  CGFloat mainScreenWidth = mainScreen.bounds.size.width;
  
  int limit = MAX(mainScreenHeight,mainScreenWidth);
  
  device.iPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
  device.iPhone = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
  device.retina = ([mainScreen scale] == 2.0);
  device.iPhone4 = (device.iPhone && limit == 480.0);
  device.iPhone5 = (device.iPhone && limit == 568.0);
  device.iPhone6 = (device.iPhone && limit == 667.0);
  device.iPhone6Plus = (device.iPhone && limit == 736.0);
  device.iPhoneX = (device.iPhone && limit == 812.0);
  device.iPhoneXrAndXsMax = (device.iPhone && limit == 896.0);
  
  return device;
}

- (NSString*)getImageName: (CDV_iOSDevice)device
{
  NSString* imageName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UILaunchImageFile"];
  
  if (imageName) {
    imageName = [imageName stringByDeletingPathExtension];
  } else {
    imageName = @"Default";
  }
//There is some deelay while geting the original resources for iPhone X and after, so we use iPhone6 resources
  if ([imageName isEqualToString:@"LaunchImage"])
  {
    if(device.iPhone4 || device.iPhone5 || device.iPad) {
      imageName = [imageName stringByAppendingString:@"-700"];
    } else if(device.iPhone6 || device.iPhoneX || device.iPhoneXrAndXsMax) {
      imageName = [imageName stringByAppendingString:@"-800"];
    } else if(device.iPhone6Plus) {
       imageName = [imageName stringByAppendingString:@"-800"];    
    } 
  }
  
  
  if (device.iPhone5) { 
    imageName = [imageName stringByAppendingString:@"-568h"];
  } else if (device.iPhone6 || device.iPhoneX || device.iPhoneXrAndXsMax) { 
    imageName = [imageName stringByAppendingString:@"-667h"];
  } else if (device.iPhone6Plus) { 
    imageName = [imageName stringByAppendingString:@"-736h"];    
  } 
  
  return imageName;
}

@end
