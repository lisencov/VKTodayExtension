//
//  ApiManager.m
//  VKTodayExtension
//
//  Created by  Sergey on 13/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import "ApiManager.h"

static NSString* rootUrl          = @"https://api.vk.com/";
static NSString* dialogsApiMethod = @"messages.getDialogs";
static NSString* usersApiMethod   = @"users.get";
static NSString* usersSearchApiMethod = @"users.search";
static NSString* messagesSendMethod = @"messages.send";

@interface ApiManager()

@property (strong, nonatomic) NSURLSession *defaultSession;

@property (strong, nonatomic) NSString* accessToken;

@end

@implementation ApiManager

+(ApiManager *)sharedInstance
{
    static ApiManager* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ApiManager alloc] init];
    });
    
    return sharedInstance;
}


-(instancetype)init
{
    if (self = [super init])
    {
        _defaultSession = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}



-(void)getDialogsWithCount:(NSInteger)count
                    offset:(NSInteger)offset
         complitionHandler:(void (^)(NSDictionary *, NSError *))onComplite
{
    
    NSURL *url = [self constructGetMethodURLWithParams:@{
                                                         @"count" : [NSNumber numberWithInteger:count],
                                                         @"offset": [NSNumber numberWithInteger:offset],
                                                         @"access_token": self.accessToken,
                                                         @"v" : @"5.60"
                                                         }
                                             forMethod:dialogsApiMethod];
    [self executeGETRequestWithURL:url complitionHandler:onComplite];
    
    
}

-(void)getUserInformationById:(NSInteger)uid complitionHandler:(void (^)(NSDictionary *, NSError *))onComplite
{
    NSURL *url = [self constructGetMethodURLWithParams:@{
                                                         @"user_ids" : [NSNumber numberWithInteger:uid],
                                                         @"fields"   : @"photo_50"
                                                         }
                                             forMethod:usersApiMethod];
    [self executeGETRequestWithURL:url complitionHandler:onComplite];
}

-(void)searchFriendsWithString:(NSString *)searchString complitionHandler:(void (^)(NSDictionary *, NSError *))complitionHandler
{
    NSURL *url = [self constructGetMethodURLWithParams:@{
                                                         @"q": searchString,
                                                         @"access_token": self.accessToken,
                                                         @"v" : @"5.60",
                                                         @"from_list": @"friends"
                                                         } forMethod:usersSearchApiMethod];
    [self executeGETRequestWithURL:url complitionHandler:complitionHandler];
    
}

-(void)sendMessage:(NSString *)message toUser:(NSInteger)uid complitionHandler:(void (^)(NSDictionary *, NSError *))complitionHandler
{
    NSURL *url = [self constructGetMethodURLWithParams:@{
                                                         @"access_token": self.accessToken,
                                                         @"v" : @"5.60", 
                                                         @"user_id": [NSNumber numberWithInteger:uid],
                                                         @"message": message
                                                         } forMethod:messagesSendMethod];
    [self executeGETRequestWithURL:url complitionHandler:complitionHandler];
}

-(void)logout
{
    NSURL *url = [NSURL URLWithString: [rootUrl stringByAppendingPathComponent:@"oauth/logout"]];
    [self  executeGETRequestWithURL:url complitionHandler:nil];
}

-(void)setNewAccessToken:(NSString *)token
{
    self.accessToken = token;
}

-(void)executeGETRequestWithURL:(NSURL*)url complitionHandler:(void (^)(NSDictionary *, NSError *))onComplite
{
    NSURLSessionDataTask *dataTask =
    [self.defaultSession dataTaskWithURL:url
                       completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
     {
         NSDictionary *responseJSON;
         
         if (!error)
         {
             responseJSON = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingAllowFragments
                                                              error:nil];
         }
         if(onComplite)
         {
             onComplite(responseJSON, error);
         }
         
     }];
    
    [dataTask resume];
}

-(NSURL*)constructGetMethodURLWithParams:(NSDictionary*)params forMethod:(NSString*)method
{
    NSString *urlString = [NSString stringWithFormat:@"%@method/%@?", rootUrl, method];
    
    for (NSString *key in [params allKeys])
    {
        urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&", key, params[key]]];
    }
    urlString = [urlString substringToIndex:[urlString length] -1];
    return [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}



@end
