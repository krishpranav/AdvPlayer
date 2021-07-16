//
//  VideoPlayerView.m
//  AdvPlayer
//
//  Created by krisna pranav on 7/16/21.
//  Copyright © 2021 krisna pranav. All rights reserved.
//

// imports
#import "VideoPlayerView.h"
#import "PSVR.h"
#import <SceneKit/SceneKit.h>



@implementation VideoPlayerView {
    EyeView * leftView;
    EyeView * rightView;
    
    AVPlayer * player;
}

- (id) initWithFrame: (NSRect) frameRect {
    if((self = [super initWithFrame: frameRect])) {
        
        NSRect r = self.bounds;
        r.size.width /= 2.0;
        leftView = [[EyeView alloc] initWithFrame: r];
        leftView.autoresizingMask = (NSViewWidthSizable | NSViewHeightSizable | NSViewMaxXMargin);
        [self addSubview: leftView];
        
        r.origin.x += r.size.width;
        rightView = [[EyeView alloc] initWithFrame: r];
        rightView.autoresizingMask = (NSViewWidthSizable | NSViewHeightSizable | NSViewMinXMargin);
        [self addSubview: rightView];
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(psvrDataReceivedNotification:)
                                                     name: PSVRDataReceivedNotification
                                                   object: [PSVR sharedInstance]];
        
    }
    return self;
}

- (void) loadURL: (NSURL *) movieURL projectionMethod: (VideoPlayerViewProjectionMethod *) projectionMethod {
    if(player) {
        return;
    }
    
    _URL = movieURL;
    _projectionMethod = projectionMethod;
    
    player = [AVPlayer playerWithURL: _URL];
    [player addObserver: self forKeyPath: @"currentItem.presentationSize" options: 0 context: 0];
    [player play];
    
}

- (void) observeValueForKeyPath: (NSString *) keyPath ofObject: (id) object change: (NSDictionary *) change context: (void *) context {
    if(object == player) {
        if([keyPath isEqualToString: @"currentItem.presentationSize"]) {
            if(player.status == AVPlayerStatusReadyToPlay) {
                
                CGSize contentSize = player.currentItem.presentationSize;
                
                for(int i = 0; i < 2; i++) {
                    
                    AVPlayerLayer * playerLayer = [AVPlayerLayer playerLayerWithPlayer: player];
                    playerLayer.videoGravity = AVLayerVideoGravityResize;
                    playerLayer.frame = CGRectMake(0,0, contentSize.width, contentSize.height);
                    
                    CALayer * eyeViewLayer = [CALayer layer];
                    eyeViewLayer.backgroundColor = [NSColor darkGrayColor].CGColor;
                    
                    EyeView * targetEyeView = (i == 0 ? leftView : rightView);
                    _projectionMethod.eyeLayerHandler(eyeViewLayer, i, contentSize, playerLayer, targetEyeView);
                    
                    [eyeViewLayer addSublayer: playerLayer];
                    
                    targetEyeView.contents = eyeViewLayer;
                    
                }
            }
        }
    }
}

- (void) toggleFullscreen {
    if([self isInFullScreenMode]) {
        [self exitFullScreenModeWithOptions: @{}];
        [NSCursor unhide];
    } else {
        [self enterFullScreenMode: [PSVR screen] withOptions: @{
                                                                NSFullScreenModeAllScreens: @(NO)
                                                                }];
        [NSCursor hide];
    }
}

- (void) advancePlaybackBySeconds: (int) sec {
    [player seekToTime: CMTimeAdd(player.currentTime, CMTimeMake(sec, 1)) toleranceBefore: kCMTimeZero toleranceAfter: kCMTimeZero];
}

@end
