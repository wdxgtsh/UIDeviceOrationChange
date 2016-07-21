//
//  ZLBaseViewController.m
//  UIDeviceOriationChange
//
//  Created by zhaolei on 16/7/20.
//  Copyright © 2016年 zhaolei. All rights reserved.
//

#import "ZLBaseViewController.h"
#include <objc/runtime.h>
#include <objc/message.h>

@implementation ZLBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
//    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
//    
//    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
    
    
    //等价于
//    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:),UIInterfaceOrientationPortrait);
    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationPortrait);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[NSString stringWithFormat:@"%@", [self class]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(10, 100, 200, 50);
        button.backgroundColor = [UIColor blueColor];
        [self.view addSubview:button];
        button;
    });
    
    [self.view addSubview:btn];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)btnClicked:(UIButton *)button{
    
}




@end
