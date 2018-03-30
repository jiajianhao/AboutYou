//
//  NSObject+Category.m
//  AboutYou
//
//  Created by 小雨科技 on 2018/3/27.
//  Copyright © 2018年 jiajianhao. All rights reserved.
//

#import "NSObject+Category.h"
#import <objc/runtime.h>
#import "AppDelegate.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
#pragma clang diagnostic ignored "-Wenum-conversion"
@implementation NSObject (Category)

-(void)setAName:(NSString *)aName{
    objc_setAssociatedObject(self, @selector(aName),  aName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)aName{
    return objc_getAssociatedObject(self,_cmd);
}

#pragma mark KVO

-(void)bindKey:(NSString *)key WithBlock:(objectKVOBlock)block{
    NSAssert(block && key, @"参数不能为空");

    if (key.length==0) {
        return ;
    }
    self.bindId=[self productUniqueId:key];
    if ([[self.blockDic allKeys]containsObject:self.bindId]) {
        return;
    }
    [self.blockDic setValue:block forKey:self.bindId];
    [self addObserverWithKey:key];
}
//添加监听
-(void)addObserverWithKey:(NSString*)key{
    
    [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(__bridge void *_Nullable)self.bindId];
 }
//实时监听
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    self.bindId = (__bridge NSString *)(context);
    [self handleKeypath:keyPath AndChange:change];
    
}
//监听处理
-(void)handleKeypath:(NSString*)keypath AndChange:(NSDictionary*)change{
    
    id newValue = change[NSKeyValueChangeNewKey];
    id oldValue = change[NSKeyValueChangeOldKey];
    objectKVOBlock block = self.blockDic[self.bindId];
    block(newValue,oldValue);
}
//生成唯一标识符
-(NSString*)productUniqueId:(NSString*)key{
    //根据"对象内存地址"和"key值"生成唯一标识符
    return [NSString stringWithFormat:@"%p....%@",self,key];
}

//Setter && Getter
-(void)setBindId:(NSString *)bindId{
    objc_setAssociatedObject(self, @selector(bindId), bindId, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)setBlockDic:(NSMutableDictionary *)blockDic{
    objc_setAssociatedObject(self, @selector(blockDic), blockDic, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
 
-(NSString *)bindId{
    return  objc_getAssociatedObject(self, _cmd);
}
-(NSMutableDictionary *)blockDic{
    if (!objc_getAssociatedObject(self, _cmd))
    {
        objc_setAssociatedObject(self, _cmd, @{}.mutableCopy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
     }
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - 销毁处理
-(void)dealloc{
    [self removeAllObserver];
}
-(void)removeAllObserver{
    // 如果没有初始化好，那么就不往下执行，防止引起崩溃。
//    if (![UIApplication sharedApplication].delegate) {
//        return;
//    }
    if (!self.blockDic.allKeys.count) {
        return;
    }
    
     for (NSString *keyStr in self.blockDic.allKeys) {
         NSString *key = [keyStr componentsSeparatedByString:@"...."].lastObject;
         [self removeObserver:self forKeyPath:key];

    }
    [self.blockDic removeAllObjects];
}
@end
