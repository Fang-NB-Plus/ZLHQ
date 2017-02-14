//
//  ViewController.m
//  buttonTest
//
//  Created by Macbook 13.3 on 2017/2/7.
//  Copyright © 2017年 方正泉. All rights reserved.
//

#import "ViewController.h"
#import "configHead.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (int i = 0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*SCREENWIDTH/4, 50, SCREENWIDTH/4, SCREENWIDTH/4);
        [btn setImage:[UIImage imageNamed:@"logo_weixin"] forState:UIControlStateNormal];

        btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [btn setTitle:@"按钮" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius  = 5;
        btn.layer.borderColor   = [UIColor blueColor].CGColor;
        btn.layer.borderWidth   = 3;
        [self.view addSubview:btn];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
