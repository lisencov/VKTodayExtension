//
//  DialogTableViewDataSource.m
//  VKTodayExtension
//
//  Created by  Sergey on 14/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import "DialogTableViewDataSource.h"
#import "DialogProtocol.h"
#import "DialogTableViewCell.h"
#import "NSThread+SimpleMainThread.h"

@interface DialogTableViewDataSource()

@property (weak, nonatomic) UITableView* tableView;
@property (weak, nonatomic) id<DialogDataSourceProtocol> dataSource;
@property (strong, nonatomic) NSString* cellIdentifire;

@end


@implementation DialogTableViewDataSource

-(instancetype)initWithTableView:(UITableView *)tableView
                      dataSource:(id<DialogDataSourceProtocol>)dataSource
          cellReusableIdentifire:(NSString *)identifire
{
    self = [super init];
    if(self)
    {
        _tableView = tableView;
        _dataSource = dataSource;
        _cellIdentifire = identifire;
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DialogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifire];
    
    id<DialogProtocol> item = [self.dataSource.data objectAtIndex:indexPath.row];
    [cell setTitle: item.title];
    [cell setBody: item.body];
    
    __weak DialogTableViewDataSource* weakSelf = self;
    [self.dataSource getDetaildInformationForDialog:item onComplete:^(id<DialogProtocol>dialog, NSError *error) {
        [weakSelf.dataSource getDialogImageForDialog:dialog onComplete:^(UIImage *image, NSError *error)
         {
             [cell setImage:image];
         }];
        
        void (^cellBlock)() = ^void()
        {
            [cell setTitle:dialog.title];
        };
        [NSThread performBlockOnMainThread:cellBlock];
    }];
    
    
    return cell;
}


@end
