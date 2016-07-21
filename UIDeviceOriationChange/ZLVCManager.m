//
//  ZLVCManager.m
//  UIDeviceOriationChange
//
//  Created by zhaolei on 16/7/20.
//  Copyright © 2016年 zhaolei. All rights reserved.
//

#import "ZLVCManager.h"
#import "ZLNavigationController.h"

@implementation ZLVCManager

+ (ZLBaseViewController *)windowRealTopVC{
    id windowRootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    if ([windowRootVC isKindOfClass:[ZLBaseViewController class]]) {
        return (ZLBaseViewController *)windowRootVC;
    }else if([windowRootVC isKindOfClass:[ZLNavigationController class]]){
        ZLNavigationController * nav = (ZLNavigationController *)windowRootVC;
        return (ZLBaseViewController *)nav.topViewController;
    }else if([windowRootVC isKindOfClass:[ZLBaseViewController class]]){
        return (ZLBaseViewController *)windowRootVC;
    }
    return nil;
}


@end
