//
//  TodayViewController.m
//  VKExtension
//
//  Created by  Sergey on 13/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "UserManager.h"
#import "ApiManager.h"
#import "VKDialogsDataSource.h"
#import "DialogTableViewCell.h"
#import "DialogTableViewDataSource.h"
#import "NSThread+SimpleMainThread.h"


@interface TodayViewController () <NCWidgetProviding, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView    *tableView;
@property (weak, nonatomic) IBOutlet UILabel        *emptyLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) UserManager           *userManager;
@property (strong, nonatomic) VKDialogsDataSource   *dataSource;

@property (strong, nonatomic) DialogTableViewDataSource *tableDataSource;

-(IBAction)touchUpInsideWidget:(id)sender;

@end

@implementation TodayViewController

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        _userManager = [[UserManager alloc] init];
        _dataSource  = [[VKDialogsDataSource alloc] initWithApiManager: [ApiManager sharedInstance]];
        _dataSource.dialogsInOneRequest = 3;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.tableDataSource == nil)
    {
        self.tableDataSource = [[DialogTableViewDataSource alloc] initWithTableView:self.tableView dataSource:self.dataSource cellReusableIdentifire:@"ExtensionCell"];
    }
    self.tableView.dataSource = self.tableDataSource;
    self.tableView.delegate   = self;
    
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    [self configurateViews];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self checkMessgaes];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)checkMessgaes
{
    if (![self.userManager isUserExist])
    {
        return;
    }
    self.tableView.hidden = YES;
    [self.activityIndicator startAnimating];
    [self.dataSource updateDataWithComplitionHandler:^(NSArray *data) {
        void (^block)() = ^void()
        {
            [self reloadTableView];
            [self.activityIndicator stopAnimating];
            self.tableView.hidden = NO;
        };
        [NSThread performBlockOnMainThread:block];
    }];
}

-(void)reloadTableView
{
    [UIView transitionWithView: self.tableView
                      duration: 0.1f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^(void)
     {
         [self.tableView reloadData];
     }
                    completion: nil];
}

-(void)configurateViews {
    if ([self.userManager isUserExist])
    {
        self.emptyLabel.hidden = YES;
        self.tableView.hidden  = NO;
    }
    else
    {
        self.emptyLabel.hidden = NO;
        self.tableView.hidden  = YES;
    }
}

-(void)touchUpInsideWidget:(id)sender
{
    NSURL *containerAppURL = [NSURL URLWithString:@"vkTodayExtension://"];
    [self.extensionContext openURL:containerAppURL completionHandler:nil];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    completionHandler(NCUpdateResultNewData);
}

-(void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
{
    if (activeDisplayMode == NCWidgetDisplayModeExpanded)
    {
        self.preferredContentSize = CGSizeMake(0.0, 300);
    }
    else
    {
        self.preferredContentSize = maxSize;
    }
}

@end
