//
//  ZLNavigationController.m
//  UIDeviceOriationChange
//
//  Created by zhaolei on 16/7/20.
//  Copyright © 2016年 zhaolei. All rights reserved.
//

#import "ZLNavigationController.h"

@implementation ZLNavigationController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    if ([[self topViewController] respondsToSelector:@selector(supportedInterfaceOrientations)]) {
        return [[self topViewController] supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    if ([[self topViewController] respondsToSelector:@selector(shouldAutorotate)]) {
        return ![[self topViewController] shouldAutorotate];
    }
    return NO;
}


@end
