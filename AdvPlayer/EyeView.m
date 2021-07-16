//
//  EyeView.m
//  AdvPlayer
//
//  Created by krisna pranav on 7/16/21.
//  Copyright © 2021 krisna pranav. All rights reserved.
//

#import "EyeView.h"

@implementation EyeView {
    SCNNode * cameraNode;
    SCNSphere * dome;
    SCNNode * domeNode;
}

- (id) initWithFrame:(NSRect)frameRect {
    if ((self = [super initWithFrame: frameRect])) {
        
        self.scene = [SCNScene scene];
        
        cameraNode = [SCNNode node];
        cameraNode.camera = [SCNCamera camera];
        cameraNode.camera.yFov = 90;
        [self.scene.rootNode addChildNode: cameraNode];
        
        
    }
}


@end
