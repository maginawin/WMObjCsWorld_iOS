//
//  WMSQLiteUserViewController.m
//  WMObjCsWorld
//
//  Created by maginawin on 15/6/18.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMSQLiteUserViewController.h"
#import "WMSQLiteManager.h"

@interface WMSQLiteUserViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *genderField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;

@end

@implementation WMSQLiteUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

// 插入
- (IBAction)searchClick:(id)sender {
    if (_nameField.text && _genderField.text && _birthdayField.text && _addressField.text) {
        WMUser* user = [[WMUser alloc] init];
        user.userName = _nameField.text;
        user.userGender = [_genderField.text integerValue];
        user.userBirthday = _birthdayField.text;
        user.userAddress = _addressField.text;
        
        if ([[WMSQLiteManager sharedInstance] insertUser:user]) {
            WMLog(@"成功插入 userName : %@", user.userName);
        } else {
            WMLog(@"插入失败");
        };
    }
}

// 查找
- (IBAction)deleteClick:(id)sender {
    if (_nameField.text) {
        NSArray* users = [[WMSQLiteManager sharedInstance] selectUsersWithUserName:_nameField.text];
        if (users.count > 0) {
            for (int i = 0; i < users.count; i++) {
                WMUser* user = users[i];
                WMLog(@"search result userName : %@", user.userName);
            }
        } else {
            WMLog(@"search result is null");
        }
    }
}

- (IBAction)editingChanged:(id)sender {
    _addressField.text = [sender text];
}


@end
