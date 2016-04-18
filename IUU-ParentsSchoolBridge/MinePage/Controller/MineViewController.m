//
//  MineViewController.m
//  IUU-ParentsSchoolBridge
//
//  Created by administrator on 16/3/25.
//  Copyright © 2016年 lyf. All rights reserved.
//

#import "MineViewController.h"
#import "HeaderViewTableViewCell.h"
#import "MineSecondTableViewCell.h"
#import "MineThirdTableViewCell.h"
#import "MePhotoViewController.h"
#import "MeRongYuViewController.h"
#import "SetingViewController.h"
#import "HomeViewController.h"
#import "Define.h"
#import "MineService.h"
#define PREFIX_URL  @"http://10.110.5.51:8887/iuuapp/"
@interface MineViewController ()
@property (strong,nonatomic)UITableView *myTab;
@property (strong,nonatomic)NSDictionary *infoDic;
@property (strong,nonatomic)NSDictionary *ddDic;
@property (strong,nonatomic)NSArray *infoArr;
@property (strong,nonatomic)NSArray *infoArr1;
@property (strong,nonatomic)NSArray *picArr;
@property (assign,nonatomic)int i;

@property (strong,nonatomic)UIImage *headerImage;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我";
    MineService *ms = [[MineService alloc]init];
    long int i = 1;
    [ms requestInfoWithtjiazhangId:i andWithSuccessInfo:^(NSDictionary *studentInfo) {
        
           NSDictionary *dic = studentInfo[@"data"];
           NSMutableArray *marr = [NSMutableArray arrayWithCapacity:0];
        [marr addObject:dic[@"sturdent_name"]];
        [marr addObject:dic[@"school_name"]];
        [marr addObject:dic[@"class_name"]];
        NSLog(@"%@",dic[@"jiazhang_touxiang"]);
        if ([dic[@"jiazhang_touxiang"]isEqualToString:@"无"] ) {
            self.headerImage = [UIImage imageNamed:@"123456.jpg"];
        }else{
        [marr addObject:dic[@"jiazhang_touxiang"]];
        }
        self.infoArr = marr;
        [self.myTab reloadData];
        
        NSString * tt = dic[@"student_id"];
        self.i = tt.intValue;
        
        if (_infoArr.count == 4) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSString *imageurl = [NSString stringWithFormat:@"%@image/mytouxiang/%@",PREFIX_URL,[_infoArr lastObject]];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageurl]];
                UIImage *image = [UIImage imageWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    _headerImage = image;
                    [self.myTab reloadData];
                    
                });
            });
            
        }
        

        
    }];
    
    
    
    
   self.infoArr = @[@" ",@" ",@" "];
    
    
    
   
    self.infoArr1 = @[@"头像",@"孩子姓名",@"学校",@"班级",@"我的地址",@"学生荣誉",@"设置"];
    
    self.picArr  = @[@"我的地址",@"我的荣誉 ",@"设置 "];
    
    [self creatTableVier];
    
    
}

-(void)creatTableVier{
    CGFloat w=self.view.frame.size.width;
    CGFloat h=self.view.frame.size.height;
    self.myTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, w, h) style:UITableViewStylePlain];
    self.myTab.backgroundColor = COLOR(248, 248, 248, 1);
    self.myTab.delegate = self;
    self.myTab.dataSource = self;
    [self.view addSubview:_myTab];
    self.myTab.tableFooterView = [[UIView alloc]init];
//    self.myTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTab.scrollEnabled = NO;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
      return 18.0;

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger H;
    if (indexPath.section==0) {
        
        if (indexPath.row ==0) {
            H = 78;
        }else{
            H = 44;
        }
    }else{
        H=44;
    }
    return H;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else{
        return 3;
    }
    

}

-(UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat w=self.view.frame.size.width;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, 18)];
    
    view.backgroundColor = COLOR(248, 248, 248, 1);
    return view;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static  NSString *Id = @"123456";
            HeaderViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
            if (cell == nil) {
                cell = [[HeaderViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.labName.text = _infoArr1[indexPath.row];
            cell.headView.image = _headerImage;
            return cell;
        }else{
            static  NSString *Id = @"12345";
            MineSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
            if (cell == nil) {
                cell = [[MineSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.text1.hidden = YES;
                cell.text2.hidden = YES;
                        }
            cell.labName.text = _infoArr1[indexPath.row];
            
            cell.textLab.text = _infoArr[indexPath.row-1];
            
            return cell;
        }
        
    }else{
        static  NSString *Id = @"1234";
        MineThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
        if (cell == nil) {
            cell = [[MineThirdTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.labName.text = _infoArr1[indexPath.row + 4];
        cell.headView.image = [UIImage imageNamed:_picArr[indexPath.row]];
        return cell;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row==0) {
            MePhotoViewController *photo =[[MePhotoViewController alloc]init];
            photo.delegate = self;
            photo.hidesBottomBarWhenPushed  = YES;//隐藏tabbar
            
            [self.navigationController pushViewController:photo animated:YES];
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            HomeViewController *sc =[[HomeViewController alloc]init];
            sc.hidesBottomBarWhenPushed  = YES;//隐藏tabbar
            sc.jiazhangid = _i;
            [self.navigationController pushViewController:sc animated:YES];
            
        }else if (indexPath.row==1){
            
            MeRongYuViewController *me =[[MeRongYuViewController alloc]init];
            me.stuId = _i;
            me.hidesBottomBarWhenPushed  = YES;//隐藏tabbar
            
            [self.navigationController pushViewController:me animated:YES];
        }else if (indexPath.row==2){
            SetingViewController *ss = [[SetingViewController alloc]init];
            ss.hidesBottomBarWhenPushed  = YES;//隐藏tabbar
            
            [self.navigationController pushViewController:ss animated:YES];
            
        }
    }

}

-(void)fanHuiChuanZhi:(UIImage *)headerImage{
    _headerImage = headerImage;
    [self.myTab reloadData];
}

@end
