//
//  VKDialog.h
//  VKTodayExtension
//
//  Created by  Sergey on 13/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DialogProtocol.h"

typedef enum VKDialogType
{
    VKDialogTypePrivate,
    VKDialogTypeMulti
}VKDialogType;

@interface VKDialog : NSObject <DialogProtocol>

@property (readonly, assign) VKDialogType type;

@end
