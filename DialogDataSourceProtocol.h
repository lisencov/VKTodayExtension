//
//  DialogDataSourceProtocol.h
//  VKTodayExtension
//
//  Created by  Sergey on 14/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DialogProtocol.h"

@protocol DialogDataSourceProtocol <NSObject>

@property (readonly, strong, nonatomic) NSArray *data;

-(void)getDialogImageForDialog:(id<DialogProtocol>)dialog onComplete:(void(^)(UIImage*image, NSError*error))onComplite;
-(void)getDetaildInformationForDialog:(id<DialogProtocol>)dialog onComplete:(void(^)(id<DialogProtocol>dialog, NSError*error))onComplite;

@end
