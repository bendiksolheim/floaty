#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

FOUNDATION_EXPORT double FullscreenVersionNumber;
FOUNDATION_EXPORT const unsigned char FullscreenVersionString[];

@interface WKPreferences()
-(void)_setFullScreenEnabled:(BOOL)fullScreenEnabled;
@end
