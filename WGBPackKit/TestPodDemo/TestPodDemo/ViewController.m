//
//  ViewController.m
//  TestPodDemo
//
//  Created by 王贵彬 on 2021/1/15.
//

#import "ViewController.h"
#import <WGBPackFramework/WGBPackFramework.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@ \n %@",[WGBLoadImageTool getJPGImage],[WGBLoadImageTool getPNGImage]);
}


@end
