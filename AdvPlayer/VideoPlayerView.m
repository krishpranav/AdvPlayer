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

@end
