//
//  VideoPlayerView.h
//  AdvPlayer
//
//  Created by krisna pranav on 7/16/21.
//  Copyright © 2021 krisna pranav. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "EyeView.h"

@class VideoPlayerViewProjectMethod;

@interface VideoPlayerView : NSView

- (void) loadURL: (NSURL *) movieURL projectionMethod: (VideoPlayerViewProjectionMethod *) projectionMethod;
- (void) toggleFullscreen;

@end
