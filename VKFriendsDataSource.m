//
//  VKFriendsDataSource.m
//  VKTodayExtension
//
//  Created by  Sergey on 21/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import "VKFriendsDataSource.h"
#import "VKFriend.h"

@interface VKFriendsDataSource()

@property (strong, nonatomic) id<ApiManagerProtocol> apiManager;

@end

@implementation VKFriendsDataSource

-(instancetype)initWithApiManager:(id<ApiManagerProtocol>)apiManager
{
    if (self = [super init])
    {
        _apiManager = apiManager;
    }
    return self;
}

-(void)friendsWithSearchString:(NSString *)searchString complitionHandler:(void (^)(NSArray *))complitionHandler
{
    
    [self.apiManager searchFriendsWithString:searchString complitionHandler:^(NSDictionary *result, NSError *error) {
        NSArray *items = result[@"response"][@"items"];
        NSMutableArray *resultArray = [NSMutableArray new];
        for (NSDictionary *item in items)
        {
            NSInteger uid = [item[@"id"] integerValue];
            VKFriend *friend = [[VKFriend alloc] initWithId:uid firstName:item[@"first_name"] lastName:item[@"last_name"]];
            [resultArray addObject:friend];
        }
        complitionHandler(resultArray);
    }];
}

@end
