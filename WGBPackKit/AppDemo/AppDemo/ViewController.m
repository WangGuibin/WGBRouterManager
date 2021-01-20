//
//  ViewController.m
//  AppDemo
//
//  Created by 王贵彬 on 2021/1/15.
//

#import "ViewController.h"
#import <WGBPackLib/WGBPackLib.h>
#import <WGBPackFramework/WGBLoadImageTool.h>

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView1.image = [WGBPackLib getJPGImage];
    self.imageView2.image = [WGBLoadImageTool getJPGImage];

}


@end
