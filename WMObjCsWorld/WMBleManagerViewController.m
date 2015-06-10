//
//  WMBleManagerViewController.m
//  WMObjCsWorld
//
//  Created by maginawin on 15/6/10.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMBleManagerViewController.h"
#import "WMBleTableViewCell.h"
#import "WMBleManagerDemo.h"

@interface WMBleManagerViewController ()

@property (weak, nonatomic) IBOutlet UITableView *peripheralTableView;

@end

@implementation WMBleManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.navigationItem.title = NSStringFromClass([WMBleManagerDemo class]);
    
    _peripheralTableView.delegate = self;
    _peripheralTableView.dataSource = self;
    
    [[WMBleManagerDemo sharedInstance] startScanningForUUIDString:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[WMBleManagerDemo sharedInstance] stopScanning];
    });
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserverForName:kBleCentralManagerDidDiscoverPeripheral object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [_peripheralTableView reloadData];
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:kBleCentralManagerDidConnectPeripheral object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        self.navigationItem.title = [[note object] name];
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:kBleCentralManagerDidDisconnectPeripheral object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        self.navigationItem.title = NSStringFromClass([WMBleManagerDemo class]);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([WMBleManagerDemo sharedInstance].didConnectedPeripheral) {
        [[WMBleManagerDemo sharedInstance] disconnectPeripheral:[WMBleManagerDemo sharedInstance].didConnectedPeripheral];
    }
}

#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [WMBleManagerDemo sharedInstance].foundPeripherals.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CBPeripheral* peripheral = [[WMBleManagerDemo sharedInstance].foundPeripherals objectAtIndex:indexPath.row];
    WMBleTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"idCell"];
    if (!cell) {
        cell = [WMBleTableViewCell sharedInstance];
    }
    cell.textLabel.text = peripheral.name;
    cell.detailTextLabel.text = peripheral.identifier.UUIDString;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CBPeripheral* peripheral = [[WMBleManagerDemo sharedInstance].foundPeripherals objectAtIndex:indexPath.row];
    [[WMBleManagerDemo sharedInstance] connectPeripheral:peripheral];
}

@end
