//
//  ViewController2.m
//  UIDeviceOriationChange
//
//  Created by zhaolei on 16/7/20.
//  Copyright © 2016年 zhaolei. All rights reserved.
//

#import "ViewController2.h"
#import "ViewController3.h"
#include <objc/runtime.h>
#include <objc/message.h>

@implementation ViewController2


- (void)viewDidLoad{
    [super viewDidLoad];
//    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationLandscapeLeft);
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"title" message:@"message" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"config", nil];
//    [alert show];
}

- (void)btnClicked:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight |
    UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    NSLog(@"%s   -----  %s", __FUNCTION__, __func__);
    return YES;
}



@end
