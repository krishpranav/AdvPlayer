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
