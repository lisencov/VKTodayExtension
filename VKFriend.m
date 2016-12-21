//
//  VKFriend.m
//  VKTodayExtension
//
//  Created by  Sergey on 21/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import "VKFriend.h"

@implementation VKFriend

-(instancetype)initWithId:(NSInteger)uid firstName:(NSString *)firstName lastName:(NSString *)lastName
{
    if (self=[super init])
    {
        _uid = uid;
        _firstName = firstName;
        _lastName  = lastName;
    }
    return self;
}

-(INPerson*)getINPerson
{
    INPersonHandle *handle = [[INPersonHandle alloc] initWithValue:[NSString stringWithFormat:@"%li", (long)self.uid] type:INPersonHandleTypeUnknown];
    //NSPersonNameComponentsFormatter *formatter = [[NSPersonNameComponents alloc] init];
    //formatter.style = NSPersonNameComponentsFormatterStyleDefault;
    //NSPersonNameComponents *components = [formatter personNameComponentsFromString:[NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName]];
    
    INPerson *person = [[INPerson alloc] initWithPersonHandle:handle nameComponents:nil displayName:[NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName] image:nil contactIdentifier:nil customIdentifier:nil];
    return person;
}

@end
