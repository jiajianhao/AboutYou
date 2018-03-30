//
//  UIButton+Block.h
//  AboutYou
//
//  Created by 小雨科技 on 2018/3/27.
//  Copyright © 2018年 jiajianhao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^btnBlock)(void);

@interface UIButton (Block)
- (void)handelWithBlock:(btnBlock)block;
- (void)handelCancelWithBlock:(btnBlock)block;

@end
