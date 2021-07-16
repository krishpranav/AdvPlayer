//
//  PSVR.h
//  AdvPlayer
//
//  Created by krisna pranav on 7/16/21.
//  Copyright © 2021 krisna pranav. All rights reserved.
//

// imports
//
//  PSVR.h
//  MacMorpheus
//
//  Created by emoRaivis on 20.10.2016.
//  Copyright © 2016 emoRaivis. All rights reserved.
//

// imports
#import <Cocoa/Cocoa.h>

@interface PSVR : NSObject

+ (instancetype) sharedInstance;

+ (NSScreen *) screen;

@end

extern NSString * const PSVRDataReceivedNotification;
extern NSString * const PSVRDataReceivedNotificationDataKey;


@interface PSVRData : NSObject

- (id) initWithData: (NSData *) data;

@property (readonly) NSData * rawData;

@property (readonly) int16_t yawAcceleration;
@property (readonly) int16_t pitchAcceleration;
@property (readonly) int16_t rollAcceleration;

@end

