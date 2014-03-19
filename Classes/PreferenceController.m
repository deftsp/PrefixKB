//
//  PreferenceController.m
//  PrefixKB
//
//  Created by Shihpin Tseng on 6/11/11.
//  Copyright 2011 palory. All rights reserved.
//

#import "PreferenceController.h"
#import "AppDelegate.h"


@implementation PreferenceController

- (id)init
{
	if (![super initWithWindowNibName:@"Preferences"]) 
		return nil;
	
	return self;
}


- (void)dealloc
{
    [super dealloc];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)addAppAsLoginItem {
	NSString * appPath = [[NSBundle mainBundle] bundlePath];
    
	// This will retrieve the path for the application
	// For example, /Applications/test.app
	CFURLRef url = (CFURLRef)[NSURL fileURLWithPath:appPath];
    
	// Create a reference to the shared file list.
	// We are adding it to the current user only.
	// If we want to add it all users, use
	// kLSSharedFileListGlobalLoginItems instead of
	//kLSSharedFileListSessionLoginItems
	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL,
															kLSSharedFileListSessionLoginItems, NULL);
	if (loginItems) {
		//Insert an item to the list.
		LSSharedFileListItemRef item = LSSharedFileListInsertItemURL(loginItems,
																	 kLSSharedFileListItemLast, NULL, NULL,
																	 url, NULL, NULL);
		if (item) {
			CFRelease(item);
		}
	}
    
	CFRelease(loginItems);
}

- (void)deleteAppFromLoginItem {
	NSString * appPath = [[NSBundle mainBundle] bundlePath];
    
	// This will retrieve the path for the application
	// For example, /Applications/test.app
	CFURLRef url = (CFURLRef)[NSURL fileURLWithPath:appPath];
    
	// Create a reference to the shared file list.
	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL,
															kLSSharedFileListSessionLoginItems, NULL);
    
	if (loginItems) {
		UInt32 seedValue;
		//Retrieve the list of Login Items and cast them to
		// a NSArray so that it will be easier to iterate.
		NSArray  *loginItemsArray = (NSArray *)LSSharedFileListCopySnapshot(loginItems, &seedValue);
        /*	int i = 0;
         for(i ; i< [loginItemsArray count]; i++){
         LSSharedFileListItemRef itemRef = (LSSharedFileListItemRef)[loginItemsArray
         objectAtIndex:i];
         //Resolve the item with URL
         if (LSSharedFileListItemResolve(itemRef, 0, (CFURLRef*) &url, NULL) == noErr) {
         NSString * urlPath = [(NSURL*)url path];
         if ([urlPath compare:appPath] == NSOrderedSame){
         LSSharedFileListItemRemove(loginItems,itemRef);
         }
         }
         }
         */
		for(id itemRef in loginItemsArray){
			if (LSSharedFileListItemResolve((LSSharedFileListItemRef)itemRef, 0, (CFURLRef*) &url, NULL) == noErr) {
				NSString * urlPath = [(NSURL*)url path];
				if ([urlPath compare:appPath] == NSOrderedSame){
					LSSharedFileListItemRemove(loginItems,(LSSharedFileListItemRef)itemRef);
				}
			}
            
		}
		[loginItemsArray release];
	}
}

- (IBAction)toggleAutoOpen:(id)sender
{
    NSUserDefaults *defaultValues = [(AppDelegate *)[NSApp delegate] userDefaults];

    if ([autoOpen state]) {
        [defaultValues setObject:@"ture" forKey:@"startup"];
        [self addAppAsLoginItem];
    } else {
        [defaultValues setObject:@"false" forKey:@"startup"];
        [self deleteAppFromLoginItem];
    }
}

- (int)numberOfRowsInTableView:(NSTableView *)tv
{
    return 3;
}

- (id)tableView:(NSTableView *)tv
objectValueForTableColumn:(NSTableColumn *)tableColumn
            row:(NSInteger)row
{
    return @"palory";
}


@end
