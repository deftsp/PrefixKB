//
//  KeyResponder.m
//  prefixKB
//
//  Created by Shihpin Tseng on 6/11/11.
//  Copyright 2011 palory. All rights reserved.
//

#import "KeyResponder.h"

#define MAX_APPLICATION_STACK 6

NSMutableArray *applicationStack;

@implementation KeyResponder

- (void)dealloc
{
    [echoString_ release];

    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self];
    [applicationStack release];

    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        applicationStack = [[NSMutableArray alloc] init];
        echoString_ = [[NSString alloc] initWithString:@"⌘-i "];

        [[[NSWorkspace sharedWorkspace] notificationCenter]
            addObserver:self
               selector:@selector(handleApplicationActivate:)
                   name:NSWorkspaceDidActivateApplicationNotification object:nil];
    }

    return self;
}


- (void)handleApplicationActivate:(NSNotification *)note
{

    NSString *deactiveAppName = [[[note userInfo] objectForKey:@"NSWorkspaceApplicationKey"] localizedName];

    if ([applicationStack count] > MAX_APPLICATION_STACK) {
        [applicationStack removeLastObject];
    }

    if (![deactiveAppName isEqualToString:[[NSRunningApplication currentApplication] localizedName]]) {
        if (![deactiveAppName isEqualToString:[applicationStack lastObject]]) {
            if ([applicationStack count] > 0) {
                [applicationStack removeObjectIdenticalTo:deactiveAppName];
            }

            [applicationStack addObject:deactiveAppName];

        }
    }
    // NSLog(@"%@", applicationStack);
}


- (NSString *)keycodeToString:(NSEvent*)event
{
    unsigned short keycode = [event keyCode];

    if (keycode == 0x35) return @"Escape";
    if (keycode == 0x36) return @"Command_R";
    if (keycode == 0x37) return @"Command_L";
    if (keycode == 0x38) return @"Shift_L";
    if (keycode == 0x39) return @"CapsLock";
    if (keycode == 0x3a) return @"Option_L";
    if (keycode == 0x3b) return @"Control_L";
    if (keycode == 0x3c) return @"Shift_R";
    if (keycode == 0x3d) return @"Option_R";
    if (keycode == 0x3e) return @"Control_R";
    if (keycode == 0x3f) return @"Fn";

    if (keycode == 0x7a) return @"F1";
    if (keycode == 0x78) return @"F2";
    if (keycode == 0x63) return @"F3";
    if (keycode == 0x76) return @"F4";
    if (keycode == 0x60) return @"F5";
    if (keycode == 0x61) return @"F6";
    if (keycode == 0x62) return @"F7";
    if (keycode == 0x64) return @"F8";
    if (keycode == 0x65) return @"F9";
    if (keycode == 0x6d) return @"F10";
    if (keycode == 0x67) return @"F11";
    if (keycode == 0x6f) return @"F12";
    if (keycode == 0x69) return @"F13";
    if (keycode == 0x6b) return @"F14";
    if (keycode == 0x71) return @"F15";
    if (keycode == 0x6a) return @"F16";
    if (keycode == 0x40) return @"F17";
    if (keycode == 0x4f) return @"F18";
    if (keycode == 0x50) return @"F19";

    if (keycode == 0x74) return @"PageUp";
    if (keycode == 0x79) return @"PageDown";
    if (keycode == 0x73) return @"Home";
    if (keycode == 0x77) return @"End";

    if (keycode == 0x7e) return @"Up";
    if (keycode == 0x7d) return @"Down";
    if (keycode == 0x7b) return @"Left";
    if (keycode == 0x7c) return @"Right";

    if (keycode == 0x24) return @"Return";
    if (keycode == 0x30) return @"Tab";
    if (keycode == 0x31) return @"Space";
    if (keycode == 0x33) return @"Delete";
    if (keycode == 0x47) return @"Clear";
    if (keycode == 0x4c) return @"Enter";
    if (keycode == 0x66) return @"JIS_EISUU";
    if (keycode == 0x68) return @"JIS_KANA";
    if (keycode == 0x6e) return @"Application";
    if (keycode == 0x75) return @"ForwardDelete";

    return [event charactersIgnoringModifiers];
}


- (NSString *)getKeyString:(NSEvent *)e
{
    NSString *keycodeString = [NSString stringWithString:[self keycodeToString:e]];

    NSUInteger flags = [e modifierFlags];
    NSString *modifierString = [NSString stringWithFormat:@"%s%s%s",
                                         ((flags & NSControlKeyMask) ? "C-" : ""),
                                         ((flags & NSShiftKeyMask) ? "S-" : ""),
                                         ((flags & NSCommandKeyMask) ? "M-" : "")];

    return [NSString stringWithFormat:@"%@%@", modifierString, keycodeString];
}


- (void)keyDown:(NSEvent *)e
{
    NSString *actionString;
    NSArray *actionComponents;
    NSString *action;
    NSString *actionArg;
    NSString *curKeyString = [NSString stringWithString:[self getKeyString:e]];

    if ((actionString = [[NSUserDefaults standardUserDefaults] objectForKey:curKeyString]) != nil) {
        actionComponents = [actionString componentsSeparatedByString:@" "];
        action = [actionComponents objectAtIndex:0];

        ////////////
        if ([action isEqualToString:@"Open"]) {
            actionArg = [actionComponents objectAtIndex:1];

            [[NSWorkspace sharedWorkspace] launchApplication:actionArg];
            [[NSApplication sharedApplication] hide:self];
            return ;
        }

        if ([action isEqualToString:@"Quit"]) {
            [[NSApplication sharedApplication] hide:self];
            [self setEchoString:@"⌘-i "];
            return ;
        }

        if ([action isEqualToString:@"Next"]) {
            NSString *lastAppName;

            if ([applicationStack count] > 0) {
                lastAppName = [applicationStack lastObject];
                [[NSWorkspace sharedWorkspace] launchApplication:lastAppName];
            }

            return ;
        }

        if ([action isEqualToString:@"Prev"]) {
            NSString *lastAppName;
            NSUInteger numOfAppInStack = [applicationStack count];

            if (numOfAppInStack == 0) {
                return ;
            } else if (numOfAppInStack == 1) {
                lastAppName = [applicationStack objectAtIndex:0];
            } else {
                lastAppName = [applicationStack objectAtIndex:(numOfAppInStack -2)];
            }

            [[NSWorkspace sharedWorkspace] launchApplication:lastAppName];

            return ;
        }

        if ([action isEqualToString:@"Last"]) {
            NSString *lastAppName;
            NSUInteger numOfAppInStack = [applicationStack count];

            if (numOfAppInStack == 0) {
                return ;
            } else if (numOfAppInStack == 1) {
                lastAppName = [applicationStack objectAtIndex:0];
            } else {
                lastAppName = [applicationStack objectAtIndex:(numOfAppInStack -2)];
            }

            [[NSWorkspace sharedWorkspace] launchApplication:lastAppName];

            return ;
        }

        if ([action isEqualToString:@"MoveToNextMonitor"]) {
            [self moveWindowToNextMonotor];

        }


        [self setEchoString:@"error action"];
        return ;
    }


    [self setEchoString:[NSString stringWithFormat:@"<%@> is undefined", curKeyString]];

    return ;
}

- (NSString *)echoString
{
	return echoString_;
}

- (void)setEchoString:(NSString *)s
{
	s = [s copy];
	[echoString_ release];
	echoString_ = s;
}



- (void)moveWindowToNextMonotor
{
//    //get info about the currently active application
//    NSWorkspace* workspace = [NSWorkspace sharedWorkspace];
//    NSDictionary* currentAppInfo = [workspace activeApplication];
//    
//  //  [NSRunningApplication runningApplicationsWithBundleIdentifier:];
//    
//    NSRect screenRect = [[NSScreen mainScreen] frame];
//    NSArray *screens = [NSScreen screens];
//    int preferredDisplay =  [[[NSUserDefaults  standardUserDefaults]
//                                 objectForKey:@"PreferredDisplayID"] intValue];
//
//    for (id screen in screens) {
//        CGDirectDisplayID display = (CGDirectDisplayID) [[[screen
//                                                              deviceDescription] valueForKey:@"NSScreenNumber"] unsignedIntValue];
//        if ( preferredDisplay == display ) {
//            screenRect = [screen frame];
//            break;
//        }
//    }

    //  [win setFrame:screenRect display:YES];

}

@end
