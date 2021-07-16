//
//  PSVR.m
//  AdvPlayer
//
//  Created by krisna pranav on 7/16/21.
//  Copyright © 2021 krisna pranav. All rights reserved.
//


//imports
#import "PSVR.h"
#import <IOKit/hid/IOHIDLib.h>


@interface PSVR (Private)
- (void) _processHIDValue: (IOHIDValueRef) hidValue;
@end


static void PSVR_HID_InputValueCallback(void * inContext, IOReturn inResult, void * inSender, IOHIDValueRef inValueRef) {
    [(__bridge PSVR *)inContext _processHIDValue: inValueRef];
}

@implementation PSVR

+ (instancetype) sharedInstance {
    static dispatch_once_t onceToken;
    static PSVR * sharedStreamer;
    dispatch_once(&onceToken, ^{
        sharedStreamer = [[PSVR alloc] init];
    });
    return sharedStreamer;
}

+ (NSScreen *) screen {
    return [NSScreen mainScreen];
}

- (id) init {
    if((self = [super init])) {
        
        IOHIDManagerRef managerRef = IOHIDManagerCreate(kCFAllocatorDefault, kIOHIDOptionsTypeSeizeDevice);
        IOHIDManagerScheduleWithRunLoop(managerRef, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
        IOHIDManagerSetDeviceMatching(managerRef, (__bridge CFMutableDictionaryRef)@{
                                                                                     @kIOHIDVendorIDKey: @(0x054C),
                                                                                     @kIOHIDProductIDKey: @(0x09AF)
                                                                                     });
        IOHIDManagerRegisterInputValueCallback(managerRef, PSVR_HID_InputValueCallback, (__bridge void *)(self));
        IOHIDManagerOpen(managerRef, 0);
        
    }
    return self;
}

- (void) _processHIDValue: (IOHIDValueRef) hidValue {
    if(IOHIDValueGetLength(hidValue) != 64) {
        return;
    }
    
    NSData * data = [NSData dataWithBytes: IOHIDValueGetBytePtr(hidValue) length: 64];
    
    [[NSNotificationCenter defaultCenter] postNotificationName: PSVRDataReceivedNotification
                                                        object: self
                                                      userInfo: @{ PSVRDataReceivedNotificationDataKey : [[PSVRData alloc] initWithData: data] }];
    
}

@end


NSString * const PSVRDataReceivedNotification = @"PSVRDataReceivedNotification";
NSString * const PSVRDataReceivedNotificationDataKey = @"PSVRDataReceivedNotificationDataKey";


@implementation PSVRData

- (id) initWithData: (NSData *) data {
    if((self = [super init])) {
        
        _rawData = data;
        
    }
    return self;
}

- (int16_t) yawAcceleration {
    return ([self readInt16: 20] + [self readInt16: 36]);
}

- (int16_t) pitchAcceleration {
    return ([self readInt16: 22] + [self readInt16: 38]);
}

- (int16_t) rollAcceleration {
    return ([self readInt16: 24] + [self readInt16: 40]);
}

- (int16_t) readInt16: (NSInteger) offset {
    int16_t output;
    [_rawData getBytes: &output range: NSMakeRange(offset, sizeof(output))];
    return output;
}

@end

