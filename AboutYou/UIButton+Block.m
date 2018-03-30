//
//  UIButton+Block.m
//  AboutYou
//
//  Created by 小雨科技 on 2018/3/27.
//  Copyright © 2018年 jiajianhao. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>
static const char btnKey;
static const char btnCancelKey;

@implementation UIButton (Block)
- (void)handelWithBlock:(btnBlock)block
{
    if (block)
    {
        objc_setAssociatedObject(self,&btnKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    [self addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnAction
{
    btnBlock block = objc_getAssociatedObject(self, &btnKey);
    block();
}
- (void)handelCancelWithBlock:(btnBlock)block{
    if (block)
    {
        objc_setAssociatedObject(self,&btnCancelKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    [self addTarget:self action:@selector(btnAction1) forControlEvents:UIControlEventTouchUpOutside];
}
-(void)btnAction1{
    btnBlock block = objc_getAssociatedObject(self, &btnCancelKey);
    block();
}
@end
