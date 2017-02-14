//
//  SunViewController.m
//  liangqing
//
//  Created by Macbook 13.3 on 2017/1/24.
//  Copyright © 2017年 方正泉. All rights reserved.
//

#import "SunViewController.h"
#import "SDCycleScrollView.h"
#import "configHead.h"
#import "WebViewComponent.h"
#import "smallCell.h"

#define LQURL   @"http://www.liangqing.gov.cn/contents/8274/318922.html"
#define TPURL   @"http://www.liangqing.gov.cn/channels/7232.html"
#define BSURL   @"http://www.liangqing.gov.cn/channels/7150.html"
#define LINEURL @"http://www.liangqing.gov.cn/channels/7148.html"
#define BLURL   @"http://www.liangqing.gov.cn/zwfwDemov/ResultList.aspx"

@interface SunViewController ()<UITableViewDelegate,UITableViewDataSource>{
    CGFloat _cellh;

}
@property (nonatomic,strong) SDCycleScrollView *topView;
@property (nonatomic,strong) UITableView       *tableView;
@property (nonatomic,strong) NSArray *sourceArr;
@end

@implementation SunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor whiteColor];
    
    _sourceArr = @[@{@"title":@"",
                     @"arr":@[@{@"image":@"icon_publicity",@"title":@"良庆概况"},
                              @{@"image":@"icon_city",@"title":@"投票活动"},
                              @{@"image":@"icon_query",@"title":@"办事指南"},
                              @{@"image":@"icon_vote",@"title":@"在线办事"},
                              @{@"image":@"icon_hot",@"title":@"办理查询"}
                              
                              ]}];
    // Do any additional setup after loading the view.
    [self installUI];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x049b2f5);
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica-Bold" size:19],NSFontAttributeName,nil];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH/2, 40)];
    lable.text            = @"智慧良庆";
    lable.font            = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    lable.textColor       = [UIColor whiteColor];
    lable.backgroundColor = [UIColor clearColor];
    lable.textAlignment   = NSTextAlignmentCenter;
    self.navigationItem.titleView = lable;

}
- (void)installUI{
    //scrollView 防止不同尺寸下图像显示不全
    _tableView            = [[UITableView alloc] init];
    _tableView.frame      = CGRectMake(0, 0, SCREENWIDTH, SCREENHIGHT-60);
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    //顶部轮播图
    _topView        = [SDCycleScrollView new];
    _topView.frame  = CGRectMake(0, -64, SCREENWIDTH, SCREENWIDTH*0.8);
    _topView.autoScroll = YES;

    //_topView.pageControlAliment     = SDCycleScrollViewPageContolAlimentCenter;
    
    _tableView.tableHeaderView = _topView;
    [self.view addSubview:_tableView];
    
    NSArray *arr = @[[UIImage imageNamed:@"banner1.jpg"],[UIImage imageNamed:@"banner2.jpg"],[UIImage imageNamed:@"banner3.jpg"],[UIImage imageNamed:@"banner4.jpg"]];
    _topView.localizationImagesGroup = arr;
    
    
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return _cellh;
}

#pragma mark - UITableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _sourceArr.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    smallCell *cell = [smallCell cellWithIndexPath:indexPath Dic:_sourceArr[indexPath.row] UITableView:tableView returnblock:^(CGFloat a) {
        
        _cellh = a;
        
    } andbtnBlock:^(NSDictionary * str) {
        
    }];
    
    return cell;
}





- (void)ActionTap:(UIGestureRecognizer *)ges{
    UIView *view = ges.view;
    NSLog(@"%d",view.tag);
    switch (view.tag) {
        case 2000:{//良庆概况
            WebViewComponent *webView = [WebViewComponent new];
            webView.url  = LQURL;
            //webView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webView animated:YES];
        }
            
            break;
        case 2001:{//投票活动
            
            WebViewComponent *webView = [WebViewComponent new];
            webView.url  = TPURL;
            //webView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
        case 2002:{//办事指南
            WebViewComponent *webView = [WebViewComponent new];
            webView.url  = BSURL;
            //webView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
        case 2003:{//在线办事
            WebViewComponent *webView = [WebViewComponent new];
            webView.url  = LINEURL;
            //webView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webView animated:YES];
        
        }
            break;
        case 2004:{//办理查询
            WebViewComponent *webView = [WebViewComponent new];
            webView.url  = BLURL;
            //webView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
            
        default:
            break;
    }

}
- (UIImage *)ImageFromColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, SCREENWIDTH, SCREENHIGHT);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
    
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
