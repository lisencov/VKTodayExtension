//
//  DialogTableViewDataSource.h
//  VKTodayExtension
//
//  Created by  Sergey on 14/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DialogDataSourceProtocol.h"

@interface DialogTableViewDataSource : NSObject <UITableViewDataSource>

-(instancetype)initWithTableView:(UITableView*)tableView
                      dataSource:(id<DialogDataSourceProtocol>)dataSource
          cellReusableIdentifire:(NSString*)identifire;

@end
