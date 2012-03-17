//
//  EchoView.h
//  prefixKB
//
//  Created by Shihpin Tseng on 6/10/11.
//  Copyright 2011 palory. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "keyResponder.h"

@interface EchoView : NSView {
    KeyResponder *keyResponder_;
    IBOutlet NSTextField *textField;
}

@end
