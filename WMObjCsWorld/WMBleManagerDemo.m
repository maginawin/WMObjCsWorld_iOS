//
//  WMBleManagerDemo.m
//  WMObjCsWorld
//
//  Created by maginawin on 15/6/10.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMBleManagerDemo.h"
#import "AppDelegate.h"

@implementation WMBleManagerDemo

/**
 *  ============================================================
 *  继承自此类的就请实现这个 load 方法, 用于 App 初始化时初始化 ble 单例
 *  ============================================================
 */
+ (void)load {
    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [self sharedInstance];
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }];
}

- (id)init {
    self = [super init];
    if (self) {
        _foundPeripherals = [NSMutableArray array];
    }
    return self;
}

- (void)startScanningForUUIDString:(NSString *)uuidString {
    
    if (_foundPeripherals.count > 0) {
        [_foundPeripherals removeAllObjects];
    }
    
    [super startScanningForUUIDString:uuidString];
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    if (![_foundPeripherals containsObject:peripheral]) {
        [_foundPeripherals addObject:peripheral];
    }
    
    [super centralManager:central didDiscoverPeripheral:peripheral advertisementData:advertisementData RSSI:RSSI];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    [super centralManager:central didConnectPeripheral:peripheral];
    
    _isConnected = YES;
    if (_didConnectedPeripheral) {
        [self disconnectPeripheral:_didConnectedPeripheral];
    }
    _didConnectedPeripheral = peripheral;
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    [super centralManager:central didDisconnectPeripheral:peripheral error:error];
    
    _isConnected = NO;
    _didConnectedPeripheral = nil;
}

@end
