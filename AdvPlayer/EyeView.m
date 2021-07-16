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

- (id) initWithFrame: (NSRect) frameRect {
    if((self = [super initWithFrame: frameRect])) {
        
        self.scene = [SCNScene scene];
        
        cameraNode = [SCNNode node];
        cameraNode.camera = [SCNCamera camera];
        cameraNode.camera.yFov = 90;
        [self.scene.rootNode addChildNode: cameraNode];
        
        dome = [SCNSphere sphereWithRadius: 60.0];
        dome.segmentCount = 480;
        domeNode = [SCNNode nodeWithGeometry: dome];
        [self.scene.rootNode addChildNode: domeNode];
        
        [self applyCameraTransform];
        
    }
    return self;
}

- (void) setContents: (id) contents {
    SCNMaterial * contentMaterial = [SCNMaterial material];
    contentMaterial.cullMode = SCNCullModeFront;
    contentMaterial.diffuse.contents = contents;
    contentMaterial.diffuse.contentsTransform = SCNMatrix4MakeScale(-1, 1, 1);
    contentMaterial.diffuse.wrapS = SCNWrapModeRepeat;
    dome.materials = @[contentMaterial];
}

- (id) contents {
    return dome.materials.firstObject.diffuse.contents;
}

- (void) setProjectionTransform: (SCNMatrix4)projectionTransform {
    domeNode.transform = projectionTransform;
}

- (SCNMatrix4) projectionTransform {
    return domeNode.transform;
}

- (void) setYaw: (float) yaw {
    _yaw = yaw;
    [self applyCameraTransform];
}

- (void) setPitch: (float)pitch {
    _pitch = pitch;
    [self applyCameraTransform];
}


@end
