//
//  PSVR.m
//  AdvPlayer
//
//  Created by krisna pranav on 7/16/21.
//  Copyright © 2021 krisna pranav. All rights reserved.
//

// imports
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

@end
