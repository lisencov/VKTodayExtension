//
//  NSUserDefaults+GroupDefaults.m
//  VKTodayExtension
//
//  Created by  Sergey on 13/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import "NSUserDefaults+GroupDefaults.h"

static NSString* gruopIdentifier = @"group.VKTodayExtension";

@implementation NSUserDefaults (GroupDefaults)

+(NSUserDefaults *)groupDefaults
{
    return [[NSUserDefaults alloc] initWithSuiteName:gruopIdentifier];
}


@end
