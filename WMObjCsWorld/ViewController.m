//
//  ViewController.m
//  WMObjCsWorld
//
//  Created by maginawin on 15/6/10.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "ViewController.h"
#import "WMBleManagerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)bleManagerDemo:(id)sender {
    // 以下两种初始化方法都可以
    //    WMBleManagerViewController* bmVC = [[WMBleManagerViewController alloc] initWithNibName:@"WMBleManagerViewController" bundle:nil];
    WMBleManagerViewController* bmVC = [[WMBleManagerViewController alloc] init];
    [self.navigationController pushViewController:bmVC animated:YES];
}

@end
