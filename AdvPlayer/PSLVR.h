//
//  PSLVR.h
//  AdvPlayer
//
//  Created by krisna pranav on 7/16/21.
//  Copyright © 2021 krisna pranav. All rights reserved.
//


#import <Cocoa/Cocoa.h>


@interface PSLVR : NSObject

+ (instancetype) sharedInstance;

+ (NSScreen *) screen;

@end


extern NSString * const PSVRDataReceivedNotification;
extern NSString * const PSVRDataReceivedNotificationDataKey;
