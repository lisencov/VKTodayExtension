//
//  ApiManager.h
//  VKTodayExtension
//
//  Created by  Sergey on 13/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiManagerProtocol.h"

@interface ApiManager : NSObject <ApiManagerProtocol>

+(ApiManager*)sharedInstance;

//-(instancetype)initWithAccessToken:(NSString*)accessToken;

-(void)setNewAccessToken:(NSString*)token;

@end
