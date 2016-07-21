//
//  ViewController1.m
//  UIDeviceOriationChange
//
//  Created by zhaolei on 16/7/20.
//  Copyright © 2016年 zhaolei. All rights reserved.
//

#import "ViewController1.h"
#import "ViewController2.h"
#include <objc/message.h>
#include <objc/runtime.h>
#import "Masonry.h"

#define APP_WIDTH [UIScreen mainScreen].applicationFrame.size.width
#define APP_HEIGHT [UIScreen mainScreen].applicationFrame.size.height

@interface ViewController1 ()

@property (nonatomic, assign) BOOL isLocked;

@property (nonatomic, strong) UIView * playerView;

@property (nonatomic, assign) UIDeviceOrientation currentOriation;

@property (nonatomic, strong) UIButton * lockButton;

@end

@implementation ViewController1

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    _currentOriation = UIDeviceOrientationPortrait;
    UIView *statusBarView = [[UIView alloc] init];
    statusBarView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:statusBarView];
    [statusBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.mas_equalTo(@0);
        make.height.mas_equalTo(@20);
    }];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(oriationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    
    self.playerView = [[UIView alloc] init];
    self.playerView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@20);
        make.leading.trailing.mas_equalTo(@0);
        make.height.mas_equalTo(APP_WIDTH/16*9);
    }];
    
    
    self.lockButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.lockButton setTitle:@"lock" forState:UIControlStateNormal];
    self.lockButton.backgroundColor = [UIColor blackColor];
    [self.lockButton addTarget:self action:@selector(lockVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.playerView addSubview:self.lockButton];
    [self.lockButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.centerY.mas_equalTo(@0);
        make.width.height.mas_equalTo(@100);
    }];

    
    UIButton * fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [fullScreenButton setTitle:@"全屏" forState:UIControlStateNormal];
    fullScreenButton.backgroundColor = [UIColor blackColor];
    [fullScreenButton addTarget:self action:@selector(fullScreenButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.playerView addSubview:fullScreenButton];
    [fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.mas_equalTo(@0);
        make.width.height.mas_equalTo(@100);
    }];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"下个界面" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(nextVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(@0);
        make.top.equalTo(self.playerView.mas_bottom).offset(50);
        
    }];
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor redColor];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(@0);
        make.top.equalTo(button.mas_bottom).offset(50);
        
    }];

    
//    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftButton setTitle:@"leftOriation" forState:UIControlStateNormal];
//    leftButton.backgroundColor = [UIColor blackColor];
//    [leftButton addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.playerView addSubview:leftButton];
//    
//    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.mas_equalTo(@10);
//        make.bottom.mas_equalTo(@0);
//    }];
//    
//    
//    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightButton setTitle:@"rightOriation" forState:UIControlStateNormal];
//    rightButton.backgroundColor = [UIColor blackColor];
//    [rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.playerView addSubview:rightButton];
//    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(leftButton.mas_trailing).offset(20);
//        make.bottom.mas_equalTo(@0);
//        make.width.equalTo(leftButton.mas_width);
//    }];
//    
//    UIButton * portraitButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [portraitButton setTitle:@"portraitOriation" forState:UIControlStateNormal];
//    portraitButton.backgroundColor = [UIColor blackColor];
//    [portraitButton addTarget:self action:@selector(portraitButtonCLicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.playerView addSubview:portraitButton];
//    [portraitButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.mas_equalTo(@20);
//        make.bottom.mas_equalTo(@0);
//        make.width.equalTo(leftButton.mas_width);
//        make.leading.equalTo(rightButton.mas_trailing).offset(20);
//    }];

}

- (void)back:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)fullScreenButtonClicked:(UIButton *)button{
    if (_currentOriation == UIDeviceOrientationLandscapeLeft || _currentOriation == UIDeviceOrientationLandscapeRight) {// 设置为非全屏
//        objc_msgSend([UIDevice currentDevice], @selector(setOrientation:),UIInterfaceOrientationPortrait);
        [self portraitButtonCLicked:nil];
    }else if(_currentOriation == UIDeviceOrientationPortrait){ // 设置为全屏
//        objc_msgSend([UIDevice currentDevice], @selector(setOrientation:),UIInterfaceOrientationLandscapeRight);
        [self rightButtonClicked:nil];
    }
}

- (void)leftButtonClicked:(UIButton *)button{
    NSLog(@"-----%s", __func__);
    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:),UIInterfaceOrientationLandscapeLeft);
}

- (void)rightButtonClicked:(UIButton *)button{
    NSLog(@"-----%s", __func__);
    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:),UIInterfaceOrientationLandscapeRight);
}

- (void)portraitButtonCLicked:(UIButton *)button{
    NSLog(@"-----%s", __func__);
    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:),UIInterfaceOrientationPortrait);
}




- (void)lockVC:(UIButton *)button{
    NSLog(@"-----%s", __func__);
    _isLocked = !_isLocked;
    [self.lockButton setTitleColor:_isLocked ? [UIColor redColor] : [UIColor whiteColor] forState:UIControlStateNormal];
    
    
    UIDeviceOrientation currentOriation = [UIDevice currentDevice].orientation;
    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), currentOriation);
}

- (void)nextVC:(UIButton *)button{
    ViewController2 * vc2 = [[ViewController2 alloc] init];
    [self.navigationController pushViewController:vc2 animated:YES];
}

- (void)btnClicked:(UIButton *)button{
    ViewController2 * vc2 = [[ViewController2 alloc] init];
    [self.navigationController pushViewController:vc2 animated:YES];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight |
            UIInterfaceOrientationMaskPortrait;
}

- (void)oriationDidChange:(NSNotification *)noti{
    if (!_isLocked) {
        UIDeviceOrientation oriention = [UIDevice currentDevice].orientation;
        if (oriention == UIDeviceOrientationPortrait) {
            [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(APP_WIDTH/16*9);
            }];
            [self adjustSetCurrentOriation:UIDeviceOrientationPortrait];
        }else if(oriention == UIDeviceOrientationLandscapeRight){
            [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(APP_HEIGHT);
            }];
            [self adjustSetCurrentOriation:UIDeviceOrientationLandscapeRight];
        }else if( oriention == UIDeviceOrientationLandscapeLeft){
            [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(APP_HEIGHT);
            }];
            [self adjustSetCurrentOriation:UIDeviceOrientationLandscapeLeft];
        }
    }
}

- (void)adjustSetCurrentOriation:(UIDeviceOrientation)oriation{
    if (!_isLocked) {
        _currentOriation = oriation;
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 开启
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}


- (BOOL)shouldAutorotate{
    if (_isLocked) {
        return YES;
    }
    return NO;
}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationPortrait);
//}





@end
