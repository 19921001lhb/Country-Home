//
//  SecondViewController.m
//  lhbText
//
//  Created by lhb on 16/3/16.
//  Copyright © 2016年 lhb. All rights reserved.
//

#import "SecondViewController.h"
#import "AFHTTPRequestOperationManager.h"
#define FirstComponent 0
#define SubComponent 1
#define ThirdComponent 2
#define PATH @"http://www.560315.com/MobileAPI/DictWarehouseTypeClass"
@interface SecondViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,retain)NSDictionary* dict;
@property(nonatomic,retain)NSArray* pickerArray;
@property(nonatomic,retain)NSArray* subPickerArray;
@property(nonatomic,retain)NSArray* thirdPickerArray;
@property(nonatomic,retain)NSArray* selectArray;
@property(nonatomic,retain)NSMutableArray* typeArray;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"地图" style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.rightBarButtonItem = item;
    self.addressBtn.layer.cornerRadius = 4;
    self.typeBtn.layer.cornerRadius = 4;
    self.myView.alpha=0;
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (_typeArray.count>0) {
        return 1;
    }else
    return 3;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_typeArray.count>0) {
        return [self.typeArray count];
    }else{
    if (component==FirstComponent) {
        return [self.pickerArray count];
    }
    if (component==SubComponent) {
        return [self.subPickerArray count];
    }
    if (component==ThirdComponent) {
        return [self.thirdPickerArray count];
    }
    }
    return 0;
}


#pragma mark--UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_typeArray.count>0) {
        return [_typeArray objectAtIndex:row];
    }else{
    if (component==FirstComponent) {
        return [self.pickerArray objectAtIndex:row];
    }
    if (component==SubComponent) {
        return [self.subPickerArray objectAtIndex:row];
    }
    if (component==ThirdComponent) {
        return [self.thirdPickerArray objectAtIndex:row];
    }
    }
    return nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    NSLog(@"row is %ld,Component is %ld",(long)row,(long)component);
    if (_typeArray.count>0) {
        NSInteger row = [pickerView selectedRowInComponent:0];
        self.typeBtn.titleLabel.text = [_typeArray objectAtIndex:row];
    }else{
    if (component==0) {
        self.selectArray=[_dict objectForKey:[self.pickerArray objectAtIndex:row]];
        if ([self.selectArray count]>0) {
            self.subPickerArray= [[self.selectArray objectAtIndex:0] allKeys];
        }else{
            self.subPickerArray=nil;
        }
        if ([self.subPickerArray count]>0) {
            self.thirdPickerArray=[[self.selectArray objectAtIndex:0] objectForKey:[self.subPickerArray objectAtIndex:0]];
        }else{
            self.thirdPickerArray=nil;
        }
        [pickerView selectedRowInComponent:1];
        [pickerView reloadComponent:1];
        [pickerView selectedRowInComponent:2];
        
        
    }
    if (component==1) {
        if ([_selectArray count]>0&&[_subPickerArray count]>0) {
            self.thirdPickerArray=[[self.selectArray objectAtIndex:0] objectForKey:[self.subPickerArray objectAtIndex:row]];
        }else{
            self.thirdPickerArray=nil;
        }
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    }
    
    
    [pickerView reloadComponent:2];
    NSInteger rowOne = [pickerView selectedRowInComponent:0];
    NSInteger rowTwo = [pickerView selectedRowInComponent:1];
    NSInteger rowThree = [pickerView selectedRowInComponent:2];
    NSString *city = [NSString stringWithFormat:@"%@%@%@",_pickerArray[rowOne],_subPickerArray[rowTwo],_thirdPickerArray[rowThree]];
    self.addressBtn.titleLabel.text = city;
    }
    
}



- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component==FirstComponent) {
        return 90.0;
    }
    if (component==SubComponent) {
        return 120.0;
    }
    if (component==ThirdComponent) {
        return 100.0;
    }
    return 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)typeBtn:(id)sender {
    [self.keywordTextfield resignFirstResponder];
    [self.totlaTextfield resignFirstResponder];
    [self.leftTextfield resignFirstResponder];
    _typeArray = [[NSMutableArray alloc]init];
    self.myView.alpha=1;
    self.myPickerView.dataSource = self;
    self.myPickerView.delegate = self;
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:PATH parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *dic in responseObject) {
            [_typeArray addObject:dic[@"WarehouseType"]];
            [self.myPickerView reloadAllComponents];
        }
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.description);
    }];
}

- (IBAction)certainBtn:(id)sender {
    self.myView.alpha = 0;
}

- (IBAction)searchBtn:(id)sender {
//    if (<#condition#>) {
//        <#statements#>
//    }
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:self.keywordTextfield.text,@"textOne",self.totlaTextfield.text,@"textTwo",self.leftTextfield.text,@"textThree",self.addressBtn.titleLabel.text,@"textFour",self.typeBtn.titleLabel.text,@"textFive", nil];
    NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addressBtn:(id)sender {
    [self.keywordTextfield resignFirstResponder];
    [self.totlaTextfield resignFirstResponder];
    [self.leftTextfield resignFirstResponder];
    [_typeArray removeAllObjects];
    self.myView.alpha=1;
    self.myPickerView.dataSource = self;
    self.myPickerView.delegate = self;
    
    
    NSString* plistPath=[[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    _dict=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.pickerArray=[_dict allKeys];
    self.selectArray=[_dict objectForKey:[[_dict allKeys] objectAtIndex:0]];
    if ([_selectArray count]>0) {
        self.subPickerArray= [[self.selectArray objectAtIndex:0] allKeys];
    }
    if ([_subPickerArray count]>0) {
        self.thirdPickerArray=[[self.selectArray objectAtIndex:0] objectForKey:[self.subPickerArray objectAtIndex:0]];
    }

}
@end
