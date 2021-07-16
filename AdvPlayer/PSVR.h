//
//  PSVR.h
//  AdvPlayer
//
//  Created by krisna pranav on 7/16/21.
//  Copyright © 2021 krisna pranav. All rights reserved.
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

@property (readonly) int16_t yawAccerleration;

@end
