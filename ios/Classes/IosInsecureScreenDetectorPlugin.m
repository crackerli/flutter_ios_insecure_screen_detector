#import "IosInsecureScreenDetectorPlugin.h"
#if __has_include(<ios_insecure_screen_detector/ios_insecure_screen_detector-Swift.h>)
#import <ios_insecure_screen_detector/ios_insecure_screen_detector-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ios_insecure_screen_detector-Swift.h"
#endif

@implementation IosInsecureScreenDetectorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftIosInsecureScreenDetectorPlugin registerWithRegistrar:registrar];
}
@end
