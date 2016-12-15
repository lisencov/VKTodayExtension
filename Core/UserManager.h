//
//  UserManager.h
//  VKTodayExtension
//
//  Created by  Sergey on 13/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKUser.h"
#import "AuthControllerProtocol.h"
#import "ApiManagerProtocol.h"

@interface UserManager : NSObject



-(BOOL)isUserExist;
-(VKUser*)getCurrentUser;

-(void)configurateAuthenticationController:(id<AuthControllerProtocol>)authController callback:(void (^)(VKUser*, BOOL isCanceled, NSError*))callback;

-(void)logout;

@end
