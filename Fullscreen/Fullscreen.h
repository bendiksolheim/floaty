//
//  Fullscreen.h
//  Fullscreen
//
//  Created by Bendik Solheim on 10/11/2019.
//  Copyright © 2019 Bendik Solheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

//! Project version number for Fullscreen.
FOUNDATION_EXPORT double FullscreenVersionNumber;

//! Project version string for Fullscreen.
FOUNDATION_EXPORT const unsigned char FullscreenVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <Fullscreen/PublicHeader.h>

@interface WKPreferences()
-(void)_setFullScreenEnabled:(BOOL)fullScreenEnabled;
@end
