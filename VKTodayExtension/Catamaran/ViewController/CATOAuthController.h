#import <UIKit/UIKit.h>
#import "AuthControllerProtocol.h"

@interface CATOAuthController : UIViewController <AuthControllerProtocol>

@property(nonatomic, strong, readonly) CATSocialOAuth *socialOAuth;

@property(nonatomic, copy) OAuthControllerCompletionBlock completionBlock;
@property(nonatomic, copy) OAuthControllerActionEventBlock onCancelButtonTap;

- (instancetype)initWithSocialOAuth:(CATSocialOAuth *)socialOAuth;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

@end
