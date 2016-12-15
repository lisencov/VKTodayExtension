//
//  VKDialogsDataSource.m
//  VKTodayExtension
//
//  Created by  Sergey on 14/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import "VKDialogsDataSource.h"
#import "VKDialog.h"
#import <SDWebImage/SDWebImageManager.h>

static NSString* defaultImageUrl  = @"http://vk.com/images/camera_c.gif";

@interface VKDialogsDataSource()

@property (strong, nonatomic) SDWebImageManager*     imageManager;
@property (strong, nonatomic) id<ApiManagerProtocol> apiManager;
@property (strong, nonatomic) NSArray*               data;

@end

@implementation VKDialogsDataSource

-(instancetype)initWithApiManager:(id<ApiManagerProtocol>)apiManager
{
    if (self=[super init])
    {
        _apiManager = apiManager;
        _data = [NSArray new];
        _dialogsInOneRequest = 10;
        _imageManager = [SDWebImageManager sharedManager];
    }
    return self;
}



-(void)updateDataWithComplitionHandler:(void (^)(NSArray *))complitionHandler
{
    __weak VKDialogsDataSource* weakSelf = self;
    
    [self.apiManager getDialogsWithCount:_dialogsInOneRequest offset:0 complitionHandler:^(NSDictionary *result, NSError *error) {
        NSArray *items = result[@"response"][@"items"];
        NSMutableArray *resultArray = [NSMutableArray new];
        for (NSDictionary *item in items)
        {
            VKDialog *dialog = [[VKDialog alloc] initWithDictionary:item];
            [resultArray addObject:dialog];
        }
        weakSelf.data = resultArray;
        complitionHandler(resultArray);
    }];
}

-(void)getDetaildInformationForDialog:(id<DialogProtocol>)dialog onComplete:(void (^)(id<DialogProtocol>, NSError *))onComplite
{
    if (((VKDialog*)dialog).type == VKDialogTypeMulti)
    {
        onComplite(dialog, nil);
    }
    else
    {
        if (dialog.title == nil || dialog.dialogImageUri == nil)
        {
            __weak VKDialog* weakDialog = dialog;
            [self.apiManager getUserInformationById:dialog.lastUserId
                                  complitionHandler:^(NSDictionary *result, NSError *error)
             {
                 result = [result[@"response"] firstObject];
                 weakDialog.dialogImageUri = result[@"photo_50"];
                 if (weakDialog.dialogImageUri == nil)
                 {
                     weakDialog.dialogImageUri = defaultImageUrl;
                 }
                 weakDialog.title = [NSString stringWithFormat:@"%@ %@", result[@"last_name"], result[@"first_name"]];
                 onComplite(weakDialog, error);
             }];
        }
        else
        {
            onComplite(dialog, nil);
        }
        
    }

}


-(void)getDialogImageForDialog:(VKDialog *)dialog onComplete:(void (^)(UIImage *, NSError *))onComplite
{
    if (dialog.dialogImageUri)
    {
        NSURL *url = [NSURL URLWithString:dialog.dialogImageUri];
        [self.imageManager downloadImageWithURL:url
                                        options:0
                                       progress:nil
                                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL)
        {
            onComplite(image, error);
        }];
    }
}

@end
