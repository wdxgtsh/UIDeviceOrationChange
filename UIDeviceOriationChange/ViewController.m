//
//  ViewController.m
//  UIDeviceOriationChange
//
//  Created by zhaolei on 16/7/20.
//  Copyright © 2016年 zhaolei. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
#include <objc/runtime.h>
#include <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIDeviceOrientationPortrait);
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)btnClicked:(UIButton *)button{
    ViewController1 * vc1 = [[ViewController1 alloc] init];
    [self.navigationController pushViewController:vc1 animated:YES];
}


@end
