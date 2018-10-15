#import <Cordova/CDV.h>
#import <Cordova/CDVPlugin.h>

typedef struct {
  
  
} CDV_iOSDevice;

@interface BackgroundSplashPlugin : CDVPlugin

@property (strong, nonatomic) UIView *backgroundModeView;
@property (strong, nonatomic) UINavigationController *navigationController;
@end