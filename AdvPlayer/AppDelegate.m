//
//  AppDelegate.m
//  AdvPlayer
//
//  Created by krisna pranav on 7/16/21.
//  Copyright © 2021 krisna pranav. All rights reserved.
//

// imports
#import "AppDelegate.h"
#import "PSVR.h"
#import "VideoPlayerView.h"


@implementation AppDelegate {
    IBOutlet NSWindow * mainWindow;
}


- (void) applicationDidFinishLaunching: (NSNotification *) aNotification {
    
    NSURL * targetURL = nil;
    VideoPlayerViewProjectionMethod * targetProjectionMethod = nil;
    
    if (!targetURL) {
        NSOpenPanel * openDialog = [NSOpenPanel openPanel];
    }
}

@end
