//
//  ApiManagerProtocol.h
//  VKTodayExtension
//
//  Created by  Sergey on 13/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ApiManagerProtocol <NSObject>

-(void)getDialogsWithCount:(NSInteger)count offset:(NSInteger)offset complitionHandler:(void(^)(NSDictionary*result, NSError*error))complitionHandler;

-(void)getUserInformationById:(NSInteger)uid complitionHandler:(void(^)(NSDictionary*result, NSError*error))complitionHandler;

-(void)logout;

@end
