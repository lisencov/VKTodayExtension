//
//  VKDialogProtocol.h
//  VKTodayExtension
//
//  Created by  Sergey on 14/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DialogProtocol <NSObject>

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

@property (strong, atomic) NSString*  title;
@property (strong, atomic) NSString*  body;
@property (strong, atomic) NSString*  dialogImageUri;
@property (assign, atomic) NSInteger  lastUserId;

@property (assign, atomic) BOOL       isUnread;

@end
