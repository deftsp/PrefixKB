//
//  AppDelegate.h
//  PrefixKB
//
//  Created by Shihpin Tseng on 6/6/11.
//  Copyright 2011 palory. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSMutableArray *applicationStack;

@interface AppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;
@end
