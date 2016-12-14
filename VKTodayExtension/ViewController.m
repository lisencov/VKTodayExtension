//
//  ViewController.m
//  VKTodayExtension
//
//  Created by  Sergey on 13/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import "ViewController.h"
#import "Configuration.h"
#import "CATOAuthController.h"
#import "CATSocialOAuthFactory.h"
#import "UserManager.h"
#import "ApiManager.h"
#import "VKDialogsDataSource.h"
#import "DialogTableViewCell.h"
#import "DialogTableViewDataSource.h"
#import "NSThread+SimpleMainThread.h"

@interface ViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel     *emptyLabel;
@property (weak, nonatomic) IBOutlet UIButton    *loginButton;
@property (weak, nonatomic) IBOutlet UIButton    *logoutButton;


@property (strong, nonatomic) UserManager *userManager;
@property (strong, nonatomic) VKDialogsDataSource *dataSource;
@property (strong, nonatomic) id<ApiManagerProtocol> apiManager;

@property (strong, nonatomic) DialogTableViewDataSource *tableDataSource;


-(IBAction)presentVKAuth:(id)sender;
-(IBAction)logout:(id)sender;

-(void)configurateViews;
-(void)updateData;

@end

@implementation ViewController

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        _userManager = [[UserManager alloc] init];
        _apiManager  = [ApiManager sharedInstance];
        _dataSource  = [[VKDialogsDataSource alloc] initWithApiManager:_apiManager];
        _dataSource.dialogsInOneRequest = 20;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.tableDataSource == nil)
    {
        self.tableDataSource = [[DialogTableViewDataSource alloc] initWithTableView:self.tableView dataSource:self.dataSource cellReusableIdentifire:@"MainCell"];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self.tableDataSource;
    [self configurateViews];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self updateData];
    [super viewWillAppear:YES];
}

- (void)presentVKAuth:(id)sender
{
    CATSocialOAuthFactory *factory = [[CATSocialOAuthFactory alloc] initWithConfigurator:[Configuration new]];
    CATOAuthController *oAuthController = [[CATOAuthController alloc] initWithSocialOAuth: [factory OAuthByType:OSOAuthTypeVK]];
    
    __weak CATOAuthController* weakOAuthController = oAuthController;
    __weak ViewController* weakSelf = self;
    void (^onComplition)() = ^void() {
        [weakOAuthController.navigationController dismissViewControllerAnimated:YES completion:nil];
        [weakSelf updateData];
        [weakSelf configurateViews];
    };
    [self.userManager configurateAuthenticationController:oAuthController callback:^(VKUser*user, BOOL isCanceled, NSError*error)
    {
        if (error)
        {
            NSLog(@"%@", error);
        }
        if([NSThread isMainThread])
        {
            onComplition();
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), onComplition);
        }

    }];

    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:oAuthController] animated:YES completion:nil];

}

-(void)logout:(id)sender
{
    [self.userManager logout];
    [self configurateViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configurateViews
{
    if ([self.userManager isUserExist])
    {
        self.loginButton.enabled = NO;
        self.logoutButton.enabled = YES;
        self.emptyLabel.hidden = YES;
        self.tableView.hidden = NO;
    }
    else
    {
        self.loginButton.enabled = YES;
        self.logoutButton.enabled = NO;
        self.emptyLabel.hidden = NO;
        self.tableView.hidden = YES;
    }
}


-(void)updateData
{

    if([self.userManager isUserExist])
    {
        [_dataSource updateDataWithComplitionHandler:^(NSArray *data) {
            void (^block)() = ^void ()
            {
                [self.tableView reloadData];

            };
            [NSThread performBlockOnMainThread:block];
        }];
    }
}

@end
