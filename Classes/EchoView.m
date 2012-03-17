//
//  EchoView.m
//  prefixKB
//
//  Created by Shihpin Tseng on 6/10/11.
//  Copyright 2011 palory. All rights reserved.
//

#import "EchoView.h"

@implementation EchoView

#pragma mark Keyboard Events

- (BOOL)acceptsFirstResponder
{
	return YES;
}

- (BOOL)resignFirstResponder
{
	[self setNeedsDisplay:YES];
	return YES;
}

- (BOOL)becomeFirstResponder
{
	[self setNeedsDisplay:YES];
	return YES;
}

- (void)keyDown:(NSEvent *)e
{
    [keyResponder_ keyDown:e];
    [textField setStringValue:[keyResponder_ echoString]];
    return ;
}


#pragma mark Drawing
- (NSBezierPath *) RoundedRect:(NSRect)rect withRadius:(float)radius
{
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path moveToPoint:NSMakePoint(rect.origin.x + radius + 1.0, rect.origin.y)];
    [path appendBezierPathWithArcFromPoint:NSMakePoint(rect.origin.x, rect.origin.y)
                                   toPoint:NSMakePoint(rect.origin.x, rect.origin.y + radius) radius: radius * 1.25];
    [path lineToPoint: NSMakePoint(rect.origin.x, rect.origin.y + rect.size.height - radius - 2.0)];

    [path appendBezierPathWithArcFromPoint:NSMakePoint(rect.origin.x, rect.origin.y + rect.size.height)
                                   toPoint:NSMakePoint(rect.origin.x + radius, rect.origin.y + rect.size.height)
                                    radius:radius * 1.25 ];
    [path lineToPoint:NSMakePoint(rect.origin.x + rect.size.width - radius - 2.0, rect.origin.y + rect.size.height)];
    [path appendBezierPathWithArcFromPoint:NSMakePoint( rect.origin.x + rect.size.width, rect.origin.y + rect.size.height)
                                   toPoint:NSMakePoint( rect.origin.x + rect.size.width, rect.origin.y + rect.size.height - radius)
                                    radius:radius * 1.25 ];

    [path lineToPoint:NSMakePoint(rect.origin.x + rect.size.width, rect.origin.y + radius + 2.0)];

    [path appendBezierPathWithArcFromPoint:NSMakePoint(rect.origin.x + rect.size.width, rect.origin.y)toPoint:NSMakePoint(rect.origin.x + rect.size.width - radius, rect.origin.y)
                                    radius:radius * 1.25];

    [path closePath ];

    return path;
}

- (void)drawRect:(NSRect)rect
{
    [[NSColor colorWithDeviceRed:0.2 green:0.2 blue:0.2 alpha:0.7 ] setFill];
    [[self RoundedRect:NSMakeRect(0, 0, 280, 45) withRadius:4] fill];
}

#pragma mark Misc
- (void)awakeFromNib
{
    keyResponder_ = [[KeyResponder alloc] init];
}


- (void)dealloc
{
	[super dealloc];
}


@end
