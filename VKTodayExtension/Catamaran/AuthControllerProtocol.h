//
//  AuthControllerProtocol.h
//  VKTodayExtension
//
//  Created by  Sergey on 13/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CATSocialOAuth.h"
#import "CATOAuthCredential.h"

typedef void (^OAuthControllerCompletionBlock)(CATOAuthCredential *credential, NSString *errorString, __weak UIViewController *weakOAuthController);
typedef void (^OAuthControllerActionEventBlock)(__weak UIViewController *weakOAuthController);

@protocol AuthControllerProtocol <NSObject>

@property(nonatomic, strong, readonly) CATSocialOAuth *socialOAuth;

@property(nonatomic, copy) OAuthControllerCompletionBlock completionBlock;
@property(nonatomic, copy) OAuthControllerActionEventBlock onCancelButtonTap;

- (instancetype)initWithSocialOAuth:(CATSocialOAuth *)socialOAuth;

@end
