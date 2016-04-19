//
//  DetailViewController.m
//  lhbText
//
//  Created by lhb on 16/3/16.
//  Copyright © 2016年 lhb. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableViewCell.h"
@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    NSMutableArray *dataSourcel;
    NSMutableArray *dataSourcer;
    
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [table registerNib:[UINib nibWithNibName:@"DetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"string"];
    NSArray *array = @[@"公司/个人",@"仓库名称",@"仓库总面积",@"可租用面积",@"仓库类型",@"仓库价格",@"所属区域",@"有效期",@"备注"];
    dataSourcel = [[NSMutableArray alloc]initWithArray:array];
    dataSourcer = [[NSMutableArray alloc]initWithArray:self.dataSource];
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width/2, 40)];
    [btn1 setTitle:@"收藏" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height-50, self.view.frame.size.width/2, 40)];
    [btn2 setTitle:@"拨打" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * string = @"string";
    DetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
    if(cell == nil)
    {
        cell = [[DetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    cell.lable1.text = dataSourcel[indexPath.row];
    cell.lable2.text = dataSourcer[indexPath.row];
  
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 63;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSourcel.count;
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
