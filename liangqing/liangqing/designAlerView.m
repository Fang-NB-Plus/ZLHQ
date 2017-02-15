//
//  designAlerView.m
//  liangqing
//
//  Created by Macbook 13.3 on 2017/2/14.
//  Copyright © 2017年 方正泉. All rights reserved.
//

#import "designAlerView.h"
#import "configHead.h"
#import "SDAutoLayout.h"

@interface designAlerView ()

@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)UIView    *contenView;
@property (nonatomic,copy  )myblock block;
@end

@implementation designAlerView

+(instancetype)alertcontent:(void(^)(NSInteger a))btnblock{
    designAlerView *alert = [[designAlerView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHIGHT)];
    alert.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
    alert.block = btnblock;
    if (alert) {
        [alert constractView];
        [[UIApplication sharedApplication].keyWindow.subviews.lastObject addSubview:alert];
    }
    return alert;
}
- (void)constractView{
    _contenView = [UIView new];
    _contenView.backgroundColor = [UIColor whiteColor];
    _contenView.layer.cornerRadius  = 5;
    _contenView.layer.masksToBounds = YES;
    
    UILabel *titleLB   = [[UILabel alloc] init];
    titleLB.text       = @"网络连接";
    titleLB.font       = [UIFont systemFontOfSize:20];
    titleLB.textAlignment = NSTextAlignmentCenter;
    
    UILabel *contenLB  = [UILabel new];
    contenLB.font      = [UIFont systemFontOfSize:17];
    contenLB.text      = @"智慧良庆想要设置一个VPN连接请求(可被用于监控网络流量)。请只在您信任该来源的的情况下才接受此请求。在VPN出于活动状态是，您的顶部会出现VPN图标";
    
    UIButton *cancelbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelbtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *surebtn   = [UIButton buttonWithType:UIButtonTypeCustom];
    [surebtn setTitle:@"确定" forState:UIControlStateNormal];
    [surebtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [surebtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_contenView];
    [_contenView sd_addSubviews:@[titleLB,contenLB,cancelbtn,surebtn]];
    
    _contenView.sd_layout
    .topSpaceToView(self,SCREENHIGHT/5)
    .leftSpaceToView(self,10)
    .rightSpaceToView(self,10);
    
    titleLB.sd_layout
    .topSpaceToView(_contenView,10)
    .leftEqualToView(_contenView)
    .rightEqualToView(_contenView)
    .heightIs(20);
    
    contenLB.sd_layout
    .topSpaceToView(titleLB,20)
    .leftSpaceToView(_contenView,10)
    .rightSpaceToView(_contenView,10)
    .autoHeightRatio(0);
    
    cancelbtn.sd_layout
    .topSpaceToView(contenLB,20)
    .rightEqualToView(_contenView)
    .heightIs(20)
    .widthIs(50);
    
    surebtn.sd_layout
    .topSpaceToView(contenLB,20)
    .rightSpaceToView(cancelbtn,10)
    .heightIs(20)
    .widthIs(50);
    
    [_contenView setupAutoHeightWithBottomView:surebtn bottomMargin:20];
}
-(void)btnAction:(UIButton *)btn{

    if ([btn.currentTitle isEqualToString:@"取消"]) {
        self.block?self.block(1):nil;
        
    }else{
        self.block?self.block(2):nil;
        
    }
    [self removeFromSuperview];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
