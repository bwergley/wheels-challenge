//
//  UserListViewController.m
//  WheelsChallenge
//
//  Created by Wergley, Brad on 9/6/19.
//  Copyright © 2019 Brad Wergley. All rights reserved.
//

#import "UserListViewController.h"

#import "UserManager.h"
#import "WheelsChallenge-Swift.h"

@interface UserListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spinnerView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<User *> *users;

@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView
     registerNib:[UINib nibWithNibName:@"UserTableViewCell" bundle:nil]
     forCellReuseIdentifier:[UserTableViewCell cellId]];
    
    self.tableView.alpha = 0;
    __weak typeof(self) weakSelf = self;
    [[UserManager sharedInstance] beginGetUserListWithCompletion:^(NSArray<User *> *users) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.users = [users mutableCopy];
            [weakSelf.tableView reloadData];
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.tableView.alpha = 1;
            } completion:^(BOOL finished) {
                [weakSelf.spinnerView stopAnimating];
            }];
        });
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (self.users != nil && row < self.users.count)
    {
        UserTableViewCell *cell = (UserTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:[UserTableViewCell cellId]];
        cell.user = self.users[row];
        return cell;
    }
    
    return [UITableViewCell new];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.users != nil)
    {
        return self.users.count;
    }
    else
    {
        return 0;
    }
}

- (IBAction)plusButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"AddUserSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"AddUserSegue"]) {
        AddUserViewController *vc = [segue destinationViewController];
        vc.addUserCompletionBlock = ^(User *user) {
            [self.users addObject:user];
            [self.tableView reloadData];
        };
    }
}

@end
