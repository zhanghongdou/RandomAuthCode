//
//  ViewController.m
//  RandomAuthCode
//
//  Created by haohao on 16/10/12.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ViewController.h"
#import "RandomAuthCodeView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet RandomAuthCodeView *codeViewSb;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    RandomAuthCodeView *codeView1 = [[RandomAuthCodeView alloc]initWithFrame:CGRectMake(110, 100, 100, 30)];
    codeView1.sendCodeMessageBlock = ^(NSString *text) {
        NSLog(@"%@", text);
    };
    [self.view addSubview:codeView1];
    
    self.codeViewSb.sendCodeMessageBlock= ^(NSString *text) {
        NSLog(@"%@", text);
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
