//
//  ViewController.m
//  GGGlassScrollView
//
//  Created by __无邪_ on 15/6/16.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import "ViewController.h"
#import "GGGlassScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    GGGlassScrollView *scrollView = [[GGGlassScrollView alloc] initWithFrame:self.view.frame];
    [scrollView setItems:@[@"Image.png",@"Image2.png",@"Image3.png",@"Image.png",@"Image2.png",@"Image3.png"]];
    [self.view addSubview:scrollView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
