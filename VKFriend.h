//
//  VKFriend.h
//  VKTodayExtension
//
//  Created by  Sergey on 21/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Intents/Intents.h>


@interface VKFriend : NSObject

-(instancetype)initWithId:(NSInteger)uid firstName:(NSString*)firstName lastName:(NSString*)lastName;

@property (assign, nonatomic) NSInteger uid;
@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;

-(INPerson*)getINPerson;

@end
