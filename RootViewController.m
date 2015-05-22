//
//  RootViewController.m
//  A_Star
//
//  Created by bliss_ddo on 14-8-18.
//  Copyright (c) 2014年 SELF_PRACTICE. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#define viewTag 100000
//配置一下这几个变量， 控制长宽和障碍数量。
#define XXXXX 15
#define YYYYY 20
#define Blockccc 50

- (void)viewDidLoad
{
    [super viewDidLoad];
}
static int count =0;

- (IBAction)btnTouchUpInside:(id)sender {
    count++;
    switch (count) {
        case 1:
        {
            UIView * aview = [self.view viewWithTag:viewTag];
            if (aview != nil) {
                [aview removeFromSuperview];
            }
            astarView  = [[UIAStarView alloc]initWithFrame:CGRectMake(40, 40, 768-40*2, 800) XCount:XXXXX andYCount:YYYYY];
            [self.view addSubview:astarView];
            [self.btnConfig setTitle:@"【点击生成终点】" forState:UIControlStateNormal];

        }
            break;
        case 2:
            [astarView randomEndPoint];
            [self.btnConfig setTitle:@"【点击生成起点】" forState:UIControlStateNormal];
            break;
            
        case 3:
            [astarView randomStartPoint];
            [self.btnConfig setTitle:@"【点击生成障碍】" forState:UIControlStateNormal];

            break;
        case 4:
            [astarView randomBlockWithCount:Blockccc];
            [self.btnConfig setTitle:@"【点击寻路】" forState:UIControlStateNormal];

            break;
        case 5:
            [astarView searchBestPath];
            [self.btnConfig setTitle:@"【再来一瓶】" forState:UIControlStateNormal];

        default:
            count=0;
            break;
    }
}



@end
