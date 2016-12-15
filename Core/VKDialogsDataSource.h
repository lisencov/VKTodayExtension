//
//  VKDialogsDataSource.h
//  VKTodayExtension
//
//  Created by  Sergey on 14/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ApiManagerProtocol.h"
#import "DialogDataSourceProtocol.h"

@interface VKDialogsDataSource : NSObject <DialogDataSourceProtocol>

@property (readonly, strong, nonatomic) NSArray *data;
@property (assign, nonatomic) NSInteger dialogsInOneRequest;

-(instancetype)initWithApiManager:(id<ApiManagerProtocol>)apiManager;

-(void)updateDataWithComplitionHandler:(void(^)(NSArray*data))complitionHandler;

@end
