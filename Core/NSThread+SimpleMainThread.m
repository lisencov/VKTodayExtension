//
//  NSThread+SimpleMainThread.m
//  VKTodayExtension
//
//  Created by  Sergey on 14/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import "NSThread+SimpleMainThread.h"

@implementation NSThread (SimpleMainThread)

+(void)performBlockOnMainThread:(void (^)())block
{
    if ([NSThread isMainThread])
    {
        block();
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

@end

