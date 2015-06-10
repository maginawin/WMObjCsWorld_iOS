//
//  WMBleManagerDemo.h
//  WMObjCsWorld
//
//  Created by maginawin on 15/6/10.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

// 测试 WMBleManager 的用法

#import "WMBleManager.h"

@interface WMBleManagerDemo : WMBleManager

@property (nonatomic) BOOL isConnected;

@property (strong, nonatomic) CBPeripheral* didConnectedPeripheral;

@property (strong, nonatomic) NSMutableArray* foundPeripherals;

@end
