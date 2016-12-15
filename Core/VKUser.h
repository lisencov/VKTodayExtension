//
//  VKUser.h
//  VKTodayExtension
//
//  Created by  Sergey on 13/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKUser : NSObject

@property (strong, nonatomic) NSString* accessToken;
@property (strong, nonatomic) NSDate*   expiresDate;

-(instancetype)initWithAccessToken:(NSString*)accessToken expiresDate:(NSDate*)expiresDate;

-(void)save;
-(void)forgot;

+(VKUser*)getSavedUser;

@end
