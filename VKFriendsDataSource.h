//
//  VKFriendsDataSource.h
//  VKTodayExtension
//
//  Created by  Sergey on 21/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiManagerProtocol.h"

@interface VKFriendsDataSource : NSObject

-(instancetype)initWithApiManager:(id<ApiManagerProtocol>)apiManager;

-(void)friendsWithSearchString:(NSString*)searchString complitionHandler:(void(^)(NSArray*data))complitionHandler;

@end


