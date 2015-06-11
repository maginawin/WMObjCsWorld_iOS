//
//  WMBleManager.h
//  WMCBCentral
//
//  Created by maginawin on 15/6/5.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#pragma mark - NSString const for save connected peripheral

/**
 * @return 用于保存已经连接 peripheral 的 NSString* const, 可扩展存至 UserDefaults
 */
extern NSString* const kBleSavedPeripheralIdentifier;

#pragma mark - NSString const for post central manager delegate notification

/**
 * @return (CBCentralManager*)central : 蓝牙状态改变, 取其状态 central.state
 */
extern NSString* const kBleCentralManagerDidUpdateState;

/**
 * @return (NSArray*)sendObjects : 发现 peripheral
 * @return - index0 : (CBPeripheral*)peripheral
 * @return - index1 : (NSDictionary*)advertisementData
 * @return - index2 : (NSNubmer*)RSSI
 */
extern NSString* const kBleCentralManagerDidDiscoverPeripheral;

/**
 * @return (CBPeripheral*)peripheral : 连接 peripheral
 */
extern NSString* const kBleCentralManagerDidConnectPeripheral;

/**
 * @return (CBPeripheral*)peripheral : 断开 peripheral 的连接
 */
extern NSString* const kBleCentralManagerDidDisconnectPeripheral;

/**
 * @return (CBPeripheral*)peripheral : 连接 peripheral 失败
 */
extern NSString* const kBleCentralManagerDidFailToConnectPeripheral;

#pragma mark - NSString const for post peripheral delegate notificaiton

/** 
 *  @return (CBPeripheral*)peripheral : 发现 peripheral.services
 */
extern NSString* const kBlePeripheralDidDiscoverServices;

/**
 * @return (NSArray*)sendObjects : 发现 service.characteristics
 * @return - index0 : (CBPeripheral*)peripheral
 * @return - index1 : (CBService*)service
 */
extern NSString* const kBlePeripheralDidDiscoverCharacteristicsForService;

/**
 * @return (NSArray*)sendObjects : 读或接收到 characteristic.value
 * @return - index0 : (CBperipheral*)peripheral
 * @return - index1 : (CBCharacteristic*)characteristic
 */
extern NSString* const kBlePeripheralDidUpdateValueForCharacteristic;

/** 
 * @return (NSArray*)sendObjects : 向 characteristic 中写入数据时调用
 * @return - index0 : (CBPeripheral*)peripheral
 * @return - index1 : (CBCharacteristic*)characteritsic
 */
extern NSString* const kBlePeripheralDidWriteValueForCharacteristic;

/**
 * @return (NSArray*)sendObjects : 更新或者读取 peripheral.RSSI
 * @return - index0 : (CBPeripheral*)peripheral
 * @return - index1 : (NSNumber*)RSSI
 */
extern NSString* const kBlePeripheralDidUpdateOrReadRSSI;

#pragma mark - Ble Scan NSString const for notification

/**
 * @brief 用于发送 start ble scanning 的通知
 */
extern NSString* const kBleStartScanning;

/**
 * @brief 用于发送 stop ble scanning 的通知
 */
extern NSString* const kBleStopScanning;

#pragma mark -

@interface WMBleManager : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

/**
 * @return static instancetype about Ble Manager
 */
+ (instancetype)sharedInstance;

/**
 * @brief 开始查找 peripheral
 * @param uuidString : 查找含有该 uuidString 的服务的设备, 若为 nil 则全部查找
 */
- (void)startScanningForUUIDString:(NSString*)uuidString;

/**
 * @brief 停止查找 peripheral
 */
- (void)stopScanning;

/**
 * @brief 连接 peripheral
 * @param peripheral : 需要连接的 peripheral
 */
- (void)connectPeripheral:(CBPeripheral*)peripheral;

/**
 * @brief 断开 peripheral 的连接
 * @param peripheral : 需要断开的 peripheral
 */
- (void)disconnectPeripheral:(CBPeripheral*)peripheral;

/**
 * @brief 自定义的 set notify value 方法, 包含了给  descriptor 赋值
 * @param peripheral : 使用的 peripheral
 * @param enabled : 是否 notify
 * @param characteristic :  通知特性
 */
- (void)setPeripheral:(CBPeripheral*)peripheral notifyValue:(BOOL)enabled forCharacteristic:(CBCharacteristic*)characteristic;

#pragma mark - Data handler

/**
 * @brief 将十六进制 NSData 转换成十六进制 NSString
 * @param aData : 十六进制 NSData
 * @return 十六进制 NSString
 */
+ (NSString*)hexStringFromHexData:(NSData*)aData;

/**
 * @brief 将十六进制 NSString 转成十六进制 NSData
 * @param hexString : 十六进制 NSString
 * @return 十六进制 NSData
 */
+ (NSData*)hexDataFromHexString:(NSString*)hexString;

/**
 * @brief 将十六进制 NSString 转为 NSInteger
 * @param hexString : 十六进制 NSString
 * @return 十进制 NSInteger
 */
+ (NSInteger)integerFromHexString:(NSString*)hexString;

/** 将十六进制 NSString 转为 NSString */
/**
 * @brief 将十六进制 NSString 转为 NSString
 * @param hexString : 十六进制 NSString
 * @return 十进制 NSString
 */
+ (NSString*)stringFromHexString:(NSString*)hexString;

/**
 * @brief 将十进制 NSString 转为十六进制 NSData
 * @param aString : 十进制 NSString
 * @return 十六进制 NSData
 */
+ (NSData*)hexDataFromString:(NSString*)aString;

/**
 * @brief 将十进制 NSString 转为十六进制 NSString
 * @param aString : 十进制 NSString
 * @return 十六进制 NSString
 */
+ (NSString*)hexStringFromString:(NSString*)aString;

/**
 * @brief NSInteger 转为十六进制的 NSString
 * @param aInteger : 十进制 NSInteger
 * @return 十六进制 NSString
 */
+ (NSString*)hexStringFromInteger:(NSInteger)aInteger;

@end
