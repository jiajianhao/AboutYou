//
//  NSObject+Category.h
//  AboutYou
//
//  Created by 小雨科技 on 2018/3/27.
//  Copyright © 2018年 jiajianhao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void  (^objectKVOBlock)(id newValue,id oldValue);

@interface NSObject (Category)
@property (nonatomic,copy)NSString *aName;

#pragma mark KVO
@property (nonatomic,strong)NSMutableDictionary *blockDic;
@property (nonatomic,strong)NSString *bindId;//唯一标识符

-(void)bindKey:(NSString*)key WithBlock:(objectKVOBlock)block;
@end
