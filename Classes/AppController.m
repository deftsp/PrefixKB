//
//  AppController.m
//  PrefixKB
//
//  Created by Shihpin Tseng on 6/11/11.
//  Copyright 2011 palory. All rights reserved.
//

#import "AppController.h"
#import "PreferenceController.h"


@implementation AppController

- (id)init
{
    self = [super init];
    // if (self) {
        
    // }

    return self;
}

+ (void)initialize
{

}

- (IBAction)showPreferencePanel:(id)sender
{
	// Is preferenceController nil?
	if (!preferenceController) {
		preferenceController = [[PreferenceController alloc] init];
	}
	NSLog(@"Showing %@", preferenceController);
    [NSApp activateIgnoringOtherApps:YES];
	[preferenceController showWindow:self];
}

- (void)activateStatusMenu {
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
	//[statusItem setImage:[NSImage imageNamed:@"idle"]];
    [statusItem setTitle:@"KB"];
	[statusItem setHighlightMode:YES];
	[statusItem setMenu:statusMenu];
}



- (void)awakeFromNib {
	[self activateStatusMenu];
}

- (IBAction)Quit:(id)sender {
    [NSApp terminate:self];
}


- (void)dealloc
{
    [preferenceController release];
    [statusItem release];
    [super dealloc];
}

@end
