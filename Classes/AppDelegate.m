//
//  PrefixKBAppDelegate.m
//  PrefixKB
//
//  Created by Shihpin Tseng on 6/6/11.
//  Copyright 2011 palory. All rights reserved.
//

#import "AppDelegate.h"
#import "DDHotKeyCenter.h"

@implementation AppDelegate

@synthesize window;


- (void)hotkeyWithEvent:(NSEvent *)hkEvent
{
    if ([[NSRunningApplication currentApplication] isActive]) {
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
    } else {
        // activate self
        [NSApp activateIgnoringOtherApps:YES];
        return ;
    }
}



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    DDHotKeyCenter *c = [[DDHotKeyCenter alloc] init];
    
	if (![c registerHotKeyWithKeyCode:0x22 modifierFlags:NSControlKeyMask target:self action:@selector(hotkeyWithEvent:) object:nil]) {
		NSLog(@"Unable to register hotkey");
	}
    
	[c release];


}


- (void)applicationWillBecomeActive:(NSNotification *)aNotification
{

}


- (void)applicationWillTerminate:(NSNotification *)notification
{
    DDHotKeyCenter * c= [[DDHotKeyCenter alloc] init];
	[c unregisterHotKeyWithKeyCode:0x22 modifierFlags:NSControlKeyMask];
	NSLog(@"Unregistered hotkey");
	[c release];
}


-(void)awakeFromNib{

}

@end
