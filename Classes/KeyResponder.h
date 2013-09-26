//
//  KeyResponder.h
//  prefixKB
//
//  Created by Shihpin Tseng on 6/11/11.
//  Copyright 2011 palory. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KeyResponder : NSObject {
    NSString *echoString_;
}

- (NSString *)echoString;
- (void)keyDown:(NSEvent *)e;
- (void)setEchoString:(NSString *)s;

- (void)moveWindowToNextMonotor;

@end
