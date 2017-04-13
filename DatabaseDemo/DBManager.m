//
//  DBManager.m
//  DatabaseDemo
//
//  Created by TMA103 on 4/13/17.
//  Copyright © 2017 TMA. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

static DBManager *sharedInstance = nil;
static sqlite3 *dataBase = nil;
static sqlite3_stmt *statement = nil;


+(DBManager *)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL] init];
        [sharedInstance createDB];
    }
    
    return sharedInstance;
}
-(BOOL) createDB {
    NSString *docsDir;
    NSArray *dirPaths;
    // getdocuments directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Buid the path to the database file
    dataPath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"student.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath:dataPath] == NO) {
        const char *dbpath = [dataPath UTF8String];
        if (sqlite3_open(dbpath, &dataBase) == SQLITE_OK) {
            char *errMsg;
            const char *sql_stmt = "create table if not exist studentDetail (regno integer primary key, name text, department text, year text)";
            if (sqlite3_exec(dataBase, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                isSuccess = NO;
                NSLog(@"Failed create table");
            }
            
            sqlite3_close(dataBase);
            return isSuccess;
        } else {
            isSuccess = NO;
            NSLog(@"Failed create database");
        }
    }
    
    return isSuccess;
}
-(BOOL) saveData: (NSString *) registerNumber name:(NSString *)name department:(NSString *)department year:(NSString  *) year{
    const char *dbpath = [dataPath UTF8String];
    if (sqlite3_open(dbpath, &dataBase) == SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into studentDetail (regno , name, department, year) values (\"%ld\", \"%@\", \"%@\", \"%@\")", (long)[registerNumber integerValue], name, department, year];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(dataBase, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            sqlite3_reset(statement);
            return YES;
        } else {
            sqlite3_reset(statement);
            return NO;
        }
    }
    return NO;
}

-(NSArray *) findByRegisterNumber:(NSString *)registerNumber {
    const char *dbpath = [dataPath UTF8String];
    if (sqlite3_open(dbpath, &dataBase) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"select name, department, year from studentDetail where regno=\"%@\"", registerNumber];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
        if (sqlite3_prepare_v2(dataBase, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            NSString *name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
            NSString *depa = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
            NSString *year = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
            [resultArray addObject:name];
            [resultArray addObject:depa];
            [resultArray addObject:year];
            sqlite3_reset(statement);
            return resultArray;
        } else {
            NSLog(@"Not found");
            sqlite3_reset(statement);
            return nil;
        }
    }
    
    return nil;
}

-(Student *) findByRegNumber:(NSString *)registerNumber {
    const char *dbpath = [dataPath UTF8String];
    if (sqlite3_open(dbpath, &dataBase) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"select name, department, year from studentDetail where regno=\"%@\"", registerNumber];
        const char *query_stmt = [querySQL UTF8String];
        Student *stu = [[Student alloc] init];
        if (sqlite3_prepare_v2(dataBase, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            NSString *name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
            NSString *depa = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
            NSString *year = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
            stu.name = name;
            stu.department = depa;
            stu.year = year;
            sqlite3_reset(statement);
            return stu;
        } else {
            NSLog(@"Not found");
            sqlite3_reset(statement);
            return nil;
        }
    }
    
    return nil;
}
@end