//
//  EyeView.h
//  AdvPlayer
//
//  Created by krisna pranav on 7/16/21.
//  Copyright © 2021 krisna pranav. All rights reserved.
//

// imports
#import <SceneKit/SceneKit.h>

@interface EyeView : SCNView

@property (nonatomic, assign) id contents;

@property (nonatomic, assign) SCNMatrix4 projectionTransform;

@property (nonatomic, assign) float roll;
@property (nonatomic, assign) float pitch;
@property (nonatomic, assign) float yaw;

@end
