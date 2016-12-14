//
//  Configuration.m
//  VKTodayExtension
//
//  Created by  Sergey on 13/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import "Configuration.h"

@implementation Configuration

-(NSURL *)redirectURI
{
    return [NSURL URLWithString:@"https://oauth.vk.com/blank.html"];
}

-(NSString *)vkApplicationID
{
    return @"5775439";
}

-(NSString *)vkScope
{
    return @"messages";
}

@end
