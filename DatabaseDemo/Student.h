//
//  Student.h
//  DatabaseDemo
//
//  Created by TMA103 on 4/13/17.
//  Copyright © 2017 TMA. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Student : NSObject
@property (strong, nonatomic) NSString *registerNumber;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *department;
@property (strong, nonatomic) NSString *year;
@end