//
//  PreferenceController.h
//  PrefixKB
//
//  Created by Shihpin Tseng on 6/11/11.
//  Copyright 2011 palory. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSUserDefaults *defaultValues;

@interface PreferenceController : NSWindowController {
    IBOutlet NSButton  *autoOpen;
    IBOutlet NSTableView *tableView;
}

- (IBAction)toggleAutoOpen:(id)sender;
@end