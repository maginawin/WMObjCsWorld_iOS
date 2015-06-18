//
//
//  WMObjCsWorld
//
//  Created by maginawin on 15/6/18.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMSQLiteViewController.h"
#import <sqlite3.h>
#import "WMWord.h"
#import "WMSQLiteTableViewController.h"

@interface WMSQLiteViewController ()
@property (weak, nonatomic) IBOutlet UITextField *wordField;
@property (weak, nonatomic) IBOutlet UITextField *detailField;
@property (weak, nonatomic) IBOutlet UITextField *keyField;

@end

@implementation WMSQLiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (IBAction)addWordClick:(id)sender {
    [self.view endEditing:YES];
    
    NSString* word = _wordField.text;
    NSString* detail = _detailField.text;
    
    if (word && detail && word.length > 0 && detail.length > 0) {
        sqlite3* database;
        // 新建和打开数据库, database 变量保存了打开的数据库的指针
        sqlite3_open([[self dbPath] UTF8String], &database);
        // 定义错误字符串
        char* errorMsg;
        // 定义执行创建表的 SQL 语句
        const char* createSQL = "create table if not exists my_info \
        (m_id integer primary key autoincrement, \
        m_word, \
        m_detail)";
        // 执行创建表语句
        int result = sqlite3_exec(database, createSQL, NULL, NULL, &errorMsg);
        if (result == SQLITE_OK) {
            const char* insertSQL = "insert into my_info values(null, ?, ?)";
            sqlite3_stmt* stmt;
            // 预编译 SQL 语句, stmt 变量保存了预编译结果的指针
            int insertResult = sqlite3_prepare_v2(database, insertSQL, -1, &stmt, nil);
            // 如果编译成功
            if (insertResult == SQLITE_OK) {
                // 为第 1 个 ? 占位符定参数
                sqlite3_bind_text(stmt, 1, [word UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 2, [detail UTF8String], -1, NULL);
                // 执行 SQL 语句
                sqlite3_step(stmt);
                
                // 清空
                _wordField.text = @"";
                _detailField.text = @"";
            }
            sqlite3_finalize(stmt);
        }
        // 关闭数据库
        sqlite3_close(database);
    }
}

- (IBAction)searchKeyClick:(id)sender {
    [self.view endEditing:YES];
    
    NSString* key = _keyField.text;
    if (key && key.length > 0) {
        sqlite3* database;
        sqlite3_open([[self dbPath] UTF8String], &database);
        const char* selectSQL = "select * from my_info where m_word like ?";
        sqlite3_stmt* stmt;
        int queryResult = sqlite3_prepare_v2(database, selectSQL, -1, &stmt, NULL);
        NSMutableArray* result = [NSMutableArray array];
        if (queryResult == SQLITE_OK) {
            sqlite3_bind_text(stmt, 1, [[NSString stringWithFormat:@"%%%@%%", key] UTF8String], -1, NULL);
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                int word_id = sqlite3_column_int(stmt, 0);
                char* word = (char*)sqlite3_column_text(stmt, 1);
                char* detail = (char*)sqlite3_column_text(stmt, 2);
                WMWord* wordObj = [[WMWord alloc] init];
                wordObj.wordId = word_id;
                wordObj.word = [NSString stringWithUTF8String:word];
                wordObj.wordDetail = [NSString stringWithUTF8String:detail];
                [result addObject:wordObj];
            }
        }
        sqlite3_close(database);
        
        if (result && result.count > 0) {
            WMSQLiteTableViewController* sqliteTVC = [[WMSQLiteTableViewController alloc] initWithNibName:@"WMSQLiteTableViewController" bundle:nil];
            sqliteTVC.datas = result;
            
            [self.navigationController pushViewController:sqliteTVC animated:YES];
        } else {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"没有查到数据" message:[NSString stringWithFormat:@"与 %@ 相关的单词并没有", key] delegate:nil cancelButtonTitle:@"Confirm" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

- (NSString*)dbPath {
    NSString* documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* result = [documents stringByAppendingPathComponent:@"myword.db"];
    WMLog(@"result : %@", result);
    return result;
}

@end
