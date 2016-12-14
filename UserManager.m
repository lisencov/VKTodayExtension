//
//  UserManager.m
//  VKTodayExtension
//
//  Created by  Sergey on 13/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import "UserManager.h"
#import "ApiManager.h"

@interface UserManager()

@property (strong, nonatomic) VKUser  *user;

@end

@implementation UserManager


-(BOOL)isUserExist
{
    return self.user == nil ? NO : YES;
}

-(VKUser *)getCurrentUser
{
    return self.user;
}


-(void)configurateAuthenticationController:(id<AuthControllerProtocol>)authController callback:(void (^)(VKUser *, BOOL, NSError *))callback
{
    if (!authController)
    {
        return;
    }
    __weak UserManager* weakSelf = self;
    authController.completionBlock = ^(CATOAuthCredential *credential, NSString *errorString, __weak UIViewController *weakOAuthController)
    {
        if (errorString)
        {
            NSError *error = [[NSError alloc] initWithDomain:NSURLErrorDomain code:-1 userInfo:@{@"error":errorString}];
            callback(nil, NO, error);
            return;
        }
        VKUser *user = [[VKUser alloc] initWithAccessToken:credential.accessToken expiresDate:[credential getExpiration]];
        [user save];
        [[ApiManager sharedInstance] setNewAccessToken:user.accessToken];
        [weakSelf setUser:user];
        callback(user, NO, nil);
    };
    
    authController.onCancelButtonTap = ^(__weak UIViewController *weakOAuthController)
    {
        callback(nil, YES, nil);
    };
    
}

-(void)logout
{
    [self.user forgot];
    self.user = nil;
    [[ApiManager sharedInstance] logout];
    [[ApiManager sharedInstance] setNewAccessToken:nil];
}

-(VKUser *)user
{
    if (_user == nil)
    {
        _user = [VKUser getSavedUser];
        [[ApiManager sharedInstance] setNewAccessToken:_user.accessToken];
    }
    else if (_user && [self isUserOutdate:_user])
    {
        [_user forgot];
        _user = nil;
    }
    return _user;
}

-(BOOL)isUserOutdate:(VKUser*)user
{
    return NO;
}


@end
