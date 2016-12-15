//
//  DialogTableViewCellProtocol.h
//  VKTodayExtension
//
//  Created by  Sergey on 14/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DialogTableViewCellProtocol <NSObject>

-(void)setTitle:(NSString*)title;
-(void)setBody:(NSString*)body;
-(void)setImage:(UIImage*)image;
-(void)setUnread:(BOOL)isUnread;

@end
