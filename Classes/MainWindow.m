//
//  MainWindow.m
//  prefixKB
//
//  Created by Shihpin Tseng on 6/11/11.
//  Copyright 2011 palory. All rights reserved.
//

#import "MainWindow.h"


@implementation MainWindow


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }

    return self;
}


- (id) initWithContentRect:(NSRect)contentRect
                   styleMask:(NSUInteger)aStyle
                     backing:(NSBackingStoreType)bufferingType
                       defer:(BOOL) flag
{
    self = [super initWithContentRect:contentRect styleMask:aStyle & (~NSTitledWindowMask) backing:bufferingType defer:flag];

    if( self == nil ) return nil;
    [self setHasShadow:YES];
    [self setMovableByWindowBackground:YES];
    [self setBackgroundColor:[ NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:0.0]];
    [self setOpaque:NO];

    return self;
}

- (id) initWithContentRect:(NSRect)contentRect
                   styleMask:(NSUInteger)aStyle
                     backing:(NSBackingStoreType)bufferingType
                       defer:(BOOL) flag
                      screen:(NSScreen *)screen
{
    self = [super initWithContentRect:contentRect styleMask:aStyle & (~NSTitledWindowMask) backing:bufferingType defer:flag screen:screen];
    if (self == nil ) return nil;

    [self setHasShadow:YES];
    [self setMovableByWindowBackground:YES];

    [self setBackgroundColor:[NSColor colorWithDeviceRed:0.0 green:0.0 blue:0.0 alpha:0.0]];
    [self setOpaque:NO];

    return self;
}

- (BOOL) canBecomeKeyWindow
{
    return YES;}

- (BOOL) canBecomeMainWindow
{
        return YES;
}


- (void)dealloc
{
    [super dealloc];
}

@end
