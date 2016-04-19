//
//  FirstViewController.m
//  lhbText
//
//  Created by lhb on 16/3/16.
//  Copyright © 2016年 lhb. All rights reserved.
//

#import "FirstViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "FirstTableViewCell.h"
#import "SecondViewController.h"
#import "DetailViewController.h"
#define PATH @"http://www.560315.com/MobileAPI/WarehouseList?keys=&vtypes="
@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    NSMutableArray *dataSource;

}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"求租仓库";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStyleDone target:self action:@selector(pressItem:)];
    self.navigationItem.rightBarButtonItem = item;
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [table registerNib:[UINib nibWithNibName:@"FirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"string"];
    dataSource = [[NSMutableArray alloc]init];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:PATH parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dataSource = [NSMutableArray arrayWithArray:responseObject];
        [table reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.description);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];

}
- (void)tongzhi:(NSNotification *)text{
   
    NSString *path = [NSString stringWithFormat:@"http://www.560315.com/MobileAPI/WarehouseList?keys=%@&vtypes=",text.userInfo[@"textOne"]];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [dataSource removeAllObjects];
        dataSource = [NSMutableArray arrayWithArray:responseObject];
        [table reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.description);
    }];

       
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * string = @"string";
    FirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
    if(cell == nil)
    {
        cell = [[FirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    cell.addLable.text = dataSource[indexPath.row][@"NameCHN"];
    cell.typeLable.text = @"普通仓库";

    cell.addressLable.text = [NSString stringWithFormat:@"%@%@%@",dataSource[indexPath.row][@"ProvinceName"],dataSource[indexPath.row][@"RegionName"],dataSource[indexPath.row][@"WHAddress"]];

    cell.nameLable.text = dataSource[indexPath.row][@"CustomPerson"];
    cell.phoneLable.text = dataSource[indexPath.row][@"CustomPersonTel"];
    cell.dataLable.text = [dataSource[indexPath.row][@"ReleaseTime"] substringToIndex:10];
  
    return cell;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 129;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    DetailViewController *detail = [[DetailViewController alloc]init];
    NSArray *arr = @[dataSource[indexPath.row][@"CustomPerson"],dataSource[indexPath.row][@"NameCHN"],@"WHArea",@"WHArea",dataSource[indexPath.row][@"StateName"],@"WHArea",dataSource[indexPath.row][@"WHAddress"],@"WHArea",@"WHArea"];
    detail.dataSource = [[NSMutableArray alloc]init];
    [detail.dataSource addObjectsFromArray:arr];
    [self.navigationController pushViewController:detail animated:YES];

}
-(void)pressItem:(UIBarButtonItem *)item{
    SecondViewController *sec = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:sec animated:YES];

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

@end
