//
//  ViewController.m
//  TMBuglyCrashHelper
//
//  Created by cocomanber on 2017/9/4.
//  Copyright © 2017年 cocomanber. All rights reserved.
//  相关文章描述：http://www.cocoachina.com/industry/20140414/8157.html

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    BLYLogWarn(@"Bugly 警告信息");
    BLYLogDebug(@"Bugly Debug");
    BLYLogDebug(@"----上传信息-----");
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"测试" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 200, 100, 40);
    button.center = self.view.center;
    [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"测试1" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    button2.frame = CGRectMake(100, 200, 100, 40);
    [button2 addTarget:self action:@selector(test1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"测试2" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    button3.frame = CGRectMake(100, 100, 100, 40);
    [button3 addTarget:self action:@selector(test2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}

-(void)test
{
    NSDictionary *dict = [NSDictionary dictionary];
    [dict setValue:nil forKey:@"1"];
}

-(void)test1
{
    NSLog(@"it will throw an NSException ");
    NSArray * array = @[];
    NSLog(@"the element is %@", array[1]);
}

-(void)test2
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
