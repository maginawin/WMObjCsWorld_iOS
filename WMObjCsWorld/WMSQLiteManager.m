//
//  WMSQLiteManager.m
//  WMObjCsWorld
//
//  Created by maginawin on 15/6/18.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMSQLiteManager.h"
#import "AppDelegate.h"
#import <sqlite3.h>

NSString* const kUserDatabaseName = @"user_db.db";

@implementation WMSQLiteManager
sqlite3* database;

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance setupDefauls];
    });
    return instance;
}

+ (void)load {
    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^ {
            [WMSQLiteManager sharedInstance];
        });
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }];
}

- (void)setupDefauls {
//    sqlite3* database;
    // 打开数据库
    sqlite3_open([self databasePath], &database);
    
    char* errmsg;
    const char* createTable = "create table if not exists user_tb (user_id integer primary key autoincrement, user_name, user_birthday, user_gender, user_address)";
    int createResult = sqlite3_exec(database, createTable, NULL, NULL, &errmsg);
    
    if (createResult == SQLITE_OK) {
        NSLog(@"create table success");
    } else {
        NSLog(@"create table error");
    }
    
    sqlite3_close(database);
}

- (const char*)databasePath {
    NSString* documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    return [[documents stringByAppendingPathComponent:kUserDatabaseName] UTF8String];
}

#pragma mark - Custom access

- (BOOL)insertUser:(WMUser*)user {
    if (user) {
//        sqlite3* database;
        sqlite3_open([self databasePath], &database);
        
        const char* insertSQL = "insert into user_tb values(null, ?, ?, ?, ?)";
        sqlite3_stmt* stmt;
        int insertResult = sqlite3_prepare_v2(database, insertSQL, -1, &stmt, NULL);
        
        if (insertResult == SQLITE_OK) {
            sqlite3_bind_text(stmt, 1, [user.userName UTF8String], -1, NULL);
            sqlite3_bind_text(stmt, 2, [user.userBirthday UTF8String], -1, NULL);
            sqlite3_bind_int(stmt, 3, user.userGender);
            sqlite3_bind_text(stmt, 4, [user.userAddress UTF8String], -1, NULL);
            
            sqlite3_step(stmt);
            WMLog(@"path %s", [self databasePath]);
        }
        
        sqlite3_finalize(stmt);
        sqlite3_close(database);
        
        return YES;
    }
    
    return NO;
}

- (NSArray*)selectUsersWithUserName:(NSString*)userName {
    NSMutableArray* result = [NSMutableArray array];
    if (userName) {
//        sqlite3* database;
        sqlite3_open([self databasePath], &database);
        
        const char* selectSQL = "select * from user_tb where user_name like ?";
        sqlite3_stmt* stmt;
        int selectResult = sqlite3_prepare_v2(database, selectSQL, -1, &stmt, NULL);
        
        if (selectResult == SQLITE_OK) {
            
            sqlite3_bind_text(stmt, 1, [[NSString stringWithFormat:@"%%%@%%", userName] UTF8String], -1, NULL);
            
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                int user_id = sqlite3_column_int(stmt, 0);
                char* user_name = (char*)sqlite3_column_text(stmt, 1);
                char* user_birthday = (char*)sqlite3_column_text(stmt, 2);
                int user_gender = sqlite3_column_int(stmt, 3);
                char* user_address = (char*)sqlite3_column_text(stmt, 4);
                
                WMUser* user = [[WMUser alloc] init];
                user.userId = user_id;
                user.userName = [NSString stringWithUTF8String:user_name];
                user.userBirthday = [NSString stringWithUTF8String:user_birthday];
                user.userGender = user_gender;
                user.userAddress = [NSString stringWithUTF8String:user_address];
                
                [result addObject:user];
            }
        }
        sqlite3_finalize(stmt);
        sqlite3_close(database);
    }
    
    return result;
}

@end
