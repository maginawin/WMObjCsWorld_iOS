//
//  WMSQLiteManager.h
//  WMObjCsWorld
//
//  Created by maginawin on 15/6/18.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMUser.h"

@interface WMSQLiteManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)insertUser:(WMUser*)user;

- (NSArray*)selectUsersWithUserName:(NSString*)userName;

@end
