#import "CDVNativeLogs.h"
#import <Cordova/CDV.h>

@implementation CDVNativeLogs


- (void)pluginInitialize
{
    NSString* pathForLog = [self getPath];
    [[NSFileManager defaultManager] removeItemAtPath:pathForLog error:nil];
    freopen([pathForLog cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
}

- (NSString*) getPath {
    NSArray *allPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [allPaths objectAtIndex:0];
    NSString *pathForLog = [documentsDirectory stringByAppendingPathComponent:@"cordova-plugin-nativelogs.txt"];
    return pathForLog;
}

- (void)getLog:(CDVInvokedUrlCommand*)command {

    
    NSString* callbackId = command.callbackId;
    if (command.arguments.count != 2)
    {
        NSString* error = @"missing arguments in getLog";
        NSLog(@"CDVNativeLogs: %@",error);
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
        return ;
    }
    
    int nbLines = 1000;  // maxline
    BOOL bClipboard = false;
    id value = [command argumentAtIndex:0];
    if ([value isKindOfClass:[NSNumber class]]) {
        nbLines = [value intValue];
    }
    
    value = [command argumentAtIndex:1];
    if ([value isKindOfClass:[NSNumber class]]) {
        bClipboard = [value boolValue];
    }
    

    NSString* pathForLog = [self getPath];
    NSString *stringContent = [NSString stringWithContentsOfFile:pathForLog encoding:NSUTF8StringEncoding error:nil];

    NSString* log = @"";
    NSArray *brokenByLines=[stringContent componentsSeparatedByString:@"\n"];
    

    NSRange endRange = NSMakeRange(brokenByLines.count >= nbLines ?
                                   brokenByLines.count - nbLines
                                : 0, MIN(brokenByLines.count, nbLines));
    
    for(id line in [brokenByLines subarrayWithRange:endRange])
    {
        if ([line length]==0)
            continue ;
      
        log = [log stringByAppendingString:line];
        log = [log stringByAppendingString:@"\n"];    
    }
    
    if (bClipboard) 
    {
        UIPasteboard *pb = [UIPasteboard generalPasteboard];
        [pb setString:log];
    }

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:log];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}
  

@end
