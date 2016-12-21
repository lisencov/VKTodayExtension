//
//  IntentHandler.m
//  SiriIntent
//
//  Created by  Sergey on 21/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import "IntentHandler.h"
#import "VKFriendsDataSource.h"
#import "ApiManager.h"
#import "UserManager.h"
#import "VKFriend.h"
#import <LocalAuthentication/LocalAuthentication.h>

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

@interface IntentHandler () <INSendPaymentIntentHandling>

@end

@implementation IntentHandler

- (id)handlerForIntent:(INIntent *)intent {
    // This is the default implementation.  If you want different objects to handle different intents,
    // you can override this and return the handler you want for that particular intent.
    
    return self;
}

-(void)handleSendPayment:(INSendPaymentIntent *)intent completion:(void (^)(INSendPaymentIntentResponse * _Nonnull))completion
{
    INPerson* person = intent.payee;
    NSInteger uid = [person.personHandle.value integerValue];
    NSString *message = [NSString stringWithFormat:@"Перевод реальных %@ рублей", intent.currencyAmount.amount];
    


    LAContext* laContext = [[LAContext alloc] init];
    if ([laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil])
    {
        [laContext evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"Подтвердите с touchId" reply:^(BOOL success, NSError * _Nullable error)
        {
            if (success)
            {
                [[ApiManager sharedInstance] sendMessage: message toUser:uid complitionHandler:^(NSDictionary *result, NSError *error)
                 {
                     completion([[INSendPaymentIntentResponse alloc] initWithCode:INSendPaymentIntentResponseCodeSuccess userActivity:nil]);
                 }];
            }
            else
            {
                completion([[INSendPaymentIntentResponse alloc] initWithCode:INSendPaymentIntentResponseCodeFailureCredentialsUnverified userActivity:nil]);
            }

        }];
    }
}


-(void)resolvePayeeForSendPayment:(INSendPaymentIntent *)intent withCompletion:(void (^)(INPersonResolutionResult * _Nonnull))completion
{
    UserManager *userManager = [[UserManager alloc] init];
    [userManager getCurrentUser];
    ApiManager *apiManager = [ApiManager sharedInstance];
    VKFriendsDataSource *dataSource = [[VKFriendsDataSource alloc] initWithApiManager:apiManager];
    
    NSString *searchString = [NSString stringWithFormat:@"%@", intent.payee.displayName];
    
    NSLog(@"Start request!");
    [dataSource friendsWithSearchString:searchString complitionHandler:^(NSArray *data) {
        NSLog(@"End request!");
        if (data.count == 0)
        {
            completion([INPersonResolutionResult unsupported]);
        }
        else if (data.count > 1)
        {
            NSMutableArray<INPerson*> *persons = [NSMutableArray new];
            for (VKFriend *friend in data)
            {
                [persons addObject: [friend getINPerson]];
            }
            completion([INPersonResolutionResult disambiguationWithPeopleToDisambiguate:persons]);
        }
        else if (data.count == 1)
        {
            VKFriend *friend = data[0];
            completion([INPersonResolutionResult confirmationRequiredWithPersonToConfirm:[friend getINPerson]]);
        }

    }];
}





@end
