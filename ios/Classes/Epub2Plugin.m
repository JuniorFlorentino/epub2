#import "Epub2Plugin.h"
#if __has_include(<epub2/epub2-Swift.h>)
#import <epub2/epub2-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "epub2-Swift.h"
#endif

@implementation Epub2Plugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEpub2Plugin registerWithRegistrar:registrar];
}
@end
