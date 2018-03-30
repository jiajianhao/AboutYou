//
//  ViewController.m
//  AboutYou
//
//  Created by 小雨科技 on 2018/3/22.
//  Copyright © 2018年 jiajianhao. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import "UIButton+Block.h"
#import "AboutYou-Swift.h"
#define QSFormat(format,objc) [NSString stringWithFormat:format,objc]
#define JHFormat(format,objc)  [NSString stringWithFormat:format,objc]

#define setAssignAssociated_MuDict if (!getAssociated()) {setValueAssociated(@{}.mutableCopy,Policy_Retain);}\
return getAssociated();

// 获取关联对象
#define getAssociated() objc_getAssociatedObject(self,_cmd)
// 设置assign类型的关联
#define setAssignAssociated(value,value2,policy) objc_setAssociatedObject(self,@selector(value2),value,policy)
// 设置关联的对象
#define setValueAssociated(objc,policy) objc_setAssociatedObject(self,_cmd,objc,((objc_AssociationPolicy)(policy)))
// 设置关联
#define setAssociated(value,policy) objc_setAssociatedObject(self,@selector(value), value,((objc_AssociationPolicy)(policy)))
#import "NSObject+Category.h"
#import "NSObject+Category.h"
@interface ViewController (){
    
}
/** person */
@property(nonatomic, strong)Person * person;
/** 展示的文字 */
@property(nonatomic, strong) UILabel *personAge;
@end

@implementation ViewController
#define bindOtherName(name) {NSLog(@"%@",[name stringByAppendingString:@"Ghost"]);}
#define reBindOtherName(name)  ([name stringByAppendingString:@"Wow!Ghost"])
#define myBind(hhhh) reBindOtherName(hhhh)
//void myMethodIMP(id self, SEL _cmd) {
//    doSomething();
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"[NSDate NSDate] %@",[NSDate date]);
    [self testObserver];
    [self testButtonBlock];
}
-(void)testButtonBlock{
    {
    UIButton *but1 =[UIButton buttonWithType:UIButtonTypeCustom];
    [but1 setFrame:CGRectMake(50, 100, 100, 100)];
    [but1 setBackgroundColor:[UIColor orangeColor]];
    [but1 handelWithBlock:^{
        NSLog(@"11111111111111111111");
        self.person.age=arc4random()%100;
    }];
        [but1 handelCancelWithBlock:^{
            NSLog(@"cancel");
        }];
    [self.view addSubview:but1];
    }
    {
    UIButton *but1 =[UIButton buttonWithType:UIButtonTypeCustom];
    [but1 setFrame:CGRectMake(50, 210, 100, 100)];
    [but1 setBackgroundColor:[UIColor orangeColor]];
        but1.tag=1;
    [but1 handelWithBlock:^{
        NSLog(@"222222222222222222");
        self.person.age=arc4random()%100;
    }];
    [self.view addSubview:but1];
    }
    {
        UIButton *but1 =[UIButton buttonWithType:UIButtonTypeCustom];
        [but1 setFrame:CGRectMake(100, 320, 100, 100)];
        [but1 setBackgroundColor:[UIColor orangeColor]];
        but1.tag=2;
        [but1 handelWithBlock:^{
            NSLog(@"333333333333333");
            self.person.age=arc4random()%100;
            AViewController * vc =[AViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        
        }];
        [self.view addSubview:but1];
    }
}
-(void)testObserver{
    
    // Do any additional setup after loading the view, typically from a nib.
    //需求,让控制器能够监听到person年龄的变化,并且将最新的年龄显示到界面上去
    Person *person = [Person new];
    self.person = person;
    person.age = 10;
    
//    class_addMethod([Person class], @selector(printPerson), class_getMethodImplementation([ViewController class], @selector(find)), "v@:");
//
//    [person performSelector:@selector(printPerson)];
    
    [person performSelector:@selector(doSomething:) withObject:[NSNumber numberWithInteger:10] afterDelay:5];
    
    NSString *str = NSStringFromSelector(_cmd);
    NSLog(@"str %@",str);
    
    UILabel *personAge = [UILabel new];
    personAge.frame = CGRectMake(150, 100, 100, 100);
    personAge.text = [NSString stringWithFormat:@"%zd",person.age];
    personAge.backgroundColor = [UIColor grayColor];
    [self.view addSubview:personAge];
    
    
    
    
    self.personAge = personAge;
    
//    [self.person addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
    [self bindName:@"Yo,Yo!!"];
    bindOtherName(@"111");
    NSLog(@"%@",reBindOtherName(@"111111ssdsdf"));
    NSLog(@"%@",myBind(@"adsd "));
    self.person.aName=myBind(@"Ipad ");
    NSLog(@"%@",self.person.aName);
    
    [self.person bindKey:@"age" WithBlock:^(id newValue,id oldValue){
        NSLog(@"%@,%@",newValue,oldValue);
        self.personAge.text=[NSString stringWithFormat:@"%@",newValue];
    }];
}
-(void)find{
    NSLog(@"find");
}
-(void)bindName:(NSString*)name{
    NSLog(@"%@",[name stringByAppendingString:@"Ghost"]);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    self.person.age = 20;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    NSLog(@"keyPath=%@,object=%@,change=%@,context=%@",keyPath,object,change,context);
    
    //这里需要将NSNumber类型转换为字符串类型
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *ageStr = [numberFormatter stringFromNumber:[change objectForKey:@"new"]];
    
    
    self.personAge.text = ageStr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
