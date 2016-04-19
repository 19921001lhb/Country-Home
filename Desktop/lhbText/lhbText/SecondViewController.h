//
//  SecondViewController.h
//  lhbText
//
//  Created by lhb on 16/3/16.
//  Copyright © 2016年 lhb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *keywordTextfield;
@property (weak, nonatomic) IBOutlet UITextField *totlaTextfield;
@property (weak, nonatomic) IBOutlet UITextField *leftTextfield;
- (IBAction)typeBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UIView *myView;
- (IBAction)certainBtn:(id)sender;

- (IBAction)searchBtn:(id)sender;
- (IBAction)addressBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;
@end
