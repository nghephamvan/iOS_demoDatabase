//
//  ViewController.h
//  DatabaseDemo
//
//  Created by TMA103 on 4/13/17.
//  Copyright © 2017 TMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *rc_txtFind;
@property (strong, nonatomic) IBOutlet UITextField *rc_txtRegNo;
@property (strong, nonatomic) IBOutlet UITextField *rc_txtName;
@property (strong, nonatomic) IBOutlet UITextField *rc_txtDepa;
@property (strong, nonatomic) IBOutlet UITextField *rc_txtYear;
- (IBAction)rc_btnSumit:(UIButton *)sender;
- (IBAction)rc_txtFindEditingChanged:(UITextField *)sender;
@end

