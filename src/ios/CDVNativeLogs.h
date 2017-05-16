
#import <Cordova/CDV.h>

@interface CDVNativeLogs : CDVPlugin

- (void)pluginInitialize;
- (NSString*) getPath;
- (void) getLog:(CDVInvokedUrlCommand*)command;

@end