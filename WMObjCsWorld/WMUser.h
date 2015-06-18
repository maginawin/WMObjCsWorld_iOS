//
//  WMUser.h
//  WMObjCsWorld
//
//  Created by maginawin on 15/6/18.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, kUserGender) {
    kUserGenderMale = 0,
    kUserGenderFemale = 1
};

@interface WMUser : NSObject

@property (assign, nonatomic) NSInteger userId;
@property (strong, nonatomic) NSString* userName;
@property (strong, nonatomic) NSString* userBirthday;
@property (assign, nonatomic) kUserGender userGender;
@property (strong, nonatomic) NSString* userAddress;

@end
