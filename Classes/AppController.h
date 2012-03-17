//
//  AppController.h
//  PrefixKB
//
//  Created by Shihpin Tseng on 6/11/11.
//  Copyright 2011 palory. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PreferenceController;

@interface AppController : NSObject {
	PreferenceController *preferenceController;
    NSStatusItem *statusItem;
    IBOutlet NSMenu *statusMenu;
@private

}

- (IBAction)Quit:(id)sender;
- (IBAction)showPreferencePanel:(id)sender;
- (void)activateStatusMenu;
@end
