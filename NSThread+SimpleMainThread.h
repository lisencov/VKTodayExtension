//
//  NSThread+SimpleMainThread.h
//  VKTodayExtension
//
//  Created by  Sergey on 14/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSThread (SimpleMainThread)

+(void)performBlockOnMainThread:(void(^)())block;

@end
