//
//  ViewController.m
//  BZDCircleAnimation
//
//  Created by Bruce on 15-4-5.
//  Copyright (c) 2015年 Bruce Zhu. All rights reserved.
//

#import "ViewController.h"
#import "BZDCircleGroupLayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BZDCircleGroupLayer *layer = [[BZDCircleGroupLayer alloc] init];
    layer.position = self.view.center;
    [self.view.layer addSublayer:layer];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
