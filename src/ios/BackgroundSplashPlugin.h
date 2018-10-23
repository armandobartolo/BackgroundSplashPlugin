#import <Cordova/CDV.h>
#import <Cordova/CDVPlugin.h>

typedef struct {
  
  BOOL iPhone;
  BOOL iPad;
  BOOL iPhone4;
  BOOL iPhone5;
  BOOL iPhone6;
  BOOL iPhone6Plus;
  BOOL iPhoneX;
  BOOL iPhoneXrAndXsMax;
  BOOL retina;
} CDV_iOSDevice;

@interface BackgroundSplashPlugin : CDVPlugin

@property (strong, nonatomic) UIView *backgroundModeView;
@property (strong, nonatomic) UINavigationController *navigationController;
@end