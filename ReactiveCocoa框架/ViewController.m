//
//  ViewController.m
//  ReactiveCocoa框架
//
//  Created by apple on 15/10/18.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"

#import "ReactiveCocoa.h"

@interface ViewController ()

@property (nonatomic, strong) id subscriber;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    // 只要订阅者一直在,表示需要一直订阅信号,信号不会自动被取消订阅
    // 1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        _subscriber = subscriber;
        
        // 3.发送信号
        [subscriber sendNext:@1];
        
        return [RACDisposable disposableWithBlock:^{
       // 当信号取消订阅的时候就会调用
            NSLog(@"信号被取消订阅");
        }];
    }];

    // 2.订阅信号
    RACDisposable *disposable = [signal subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
        
    }];
    
    
    // 取消订阅
    [disposable dispose];
    
    
}


@end
