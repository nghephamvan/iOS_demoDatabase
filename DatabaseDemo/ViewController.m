//
//  ViewController.m
//  DatabaseDemo
//
//  Created by TMA103 on 4/13/17.
//  Copyright © 2017 TMA. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "DBManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rc_btnSumit:(UIButton *)sender {
    BOOL isSuccess = NO;
    NSString *msg = @"Add information failed";
    if (self.rc_txtRegNo.text.length>0 && self.rc_txtName.text.length>0 && self.rc_txtDepa.text.length>0 && self.rc_txtYear.text.length>0) {
        isSuccess = [[DBManager getSharedInstance] saveData:self.rc_txtRegNo.text name:self.rc_txtName.text department:self.rc_txtDepa.text year:self.rc_txtYear.text];
    } else {
        msg = @"Please enter all fields";
    }
    
    if (!isSuccess) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        msg = @"Add information successful";
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notification" message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}
@end
