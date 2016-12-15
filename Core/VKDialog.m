//
//  VKDialog.m
//  VKTodayExtension
//
//  Created by  Sergey on 13/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import "VKDialog.h"

@interface VKDialog()

@property (assign) VKDialogType type;

@end


@implementation VKDialog

@synthesize title;
@synthesize body;
@synthesize dialogImageUri;
@synthesize lastUserId;
@synthesize isUnread;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        isUnread = [dictionary[@"unread"] integerValue] > 0;
        NSDictionary *message = dictionary[@"message"];
        NSInteger chatId = [message[@"chat_id"] integerValue];
        _type = chatId > 0 ? VKDialogTypeMulti : VKDialogTypePrivate;

        body = message[@"body"];
        title = _type == VKDialogTypeMulti ? message[@"title"] : nil;
        
        if ((!body || [body isEqualToString:@""]) && message[@"fwd_messages"])
        {
            body = @"[Пересланное сообщение]";
        }
        if ((!body || [body isEqualToString:@""]) && message[@"attachments"])
        {
            body = @"[Вложение]";
        }
        
        dialogImageUri = _type == VKDialogTypeMulti ? message[@"photo_50"] : nil;
        lastUserId = [message[@"user_id"] integerValue];
    }
    return self;
}


@end
