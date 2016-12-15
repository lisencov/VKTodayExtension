//
//  VKUser.m
//  VKTodayExtension
//
//  Created by  Sergey on 13/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import "VKUser.h"
#import "NSUserDefaults+GroupDefaults.h"

static NSString* accessTokenKey = @"accessTokenKey";
static NSString* expiresDateKey = @"expiresDateKey";

@implementation VKUser

-(instancetype)initWithAccessToken:(NSString *)accessToken expiresDate:(NSDate *)expiresDate
{
    if (self = [super init])
    {
        _accessToken = accessToken;
        _expiresDate = expiresDate;
    }
    return self;
}

-(void)save
{
    NSUserDefaults *userDefaults = [NSUserDefaults groupDefaults];
    [userDefaults setObject:self.accessToken forKey:accessTokenKey];
    [userDefaults  setObject:self.expiresDate forKey:expiresDateKey];
    [userDefaults synchronize];
}

-(void)forgot
{
    NSUserDefaults *userDefaults = [NSUserDefaults groupDefaults];
    [userDefaults setObject:nil forKey:accessTokenKey];
    [userDefaults  setObject:nil forKey:expiresDateKey];
    [userDefaults synchronize];
}

+(VKUser *)getSavedUser
{

    VKUser* user;
    NSUserDefaults *userDefaults = [NSUserDefaults groupDefaults];
    NSString *accessToken = [userDefaults objectForKey:accessTokenKey];
    if (accessToken == nil || [accessToken isEqualToString:@""])
    {
        return nil;
    }
    NSDate *expiresDate = [userDefaults objectForKey:expiresDateKey];
    user = [[VKUser alloc] initWithAccessToken:accessToken expiresDate:expiresDate];
    return user;
    return nil;
}

@end
