//
//  Database.h
//  DatabaseDemo
//
//  Created by TMA103 on 4/13/17.
//  Copyright © 2017 TMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Student.h"

@interface DBManager : NSObject
{
    NSString *dataPath;
}

+(DBManager *)getSharedInstance;
-(BOOL) createDB;
-(BOOL) saveData: (NSString *) registerNumber name:(NSString *)name department:(NSString *)department year:(NSString  *) year;
-(NSArray *) findByRegisterNumber:(NSString *)registerNumber;
-(Student *) findByRegNumber:(NSString *)registerNumber;
@end
