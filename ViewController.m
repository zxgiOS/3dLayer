//
//  ViewController.m
//  3dLayer
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) CALayer *rootLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _rootLayer = [CALayer layer];
    _rootLayer.contentsScale = [UIScreen mainScreen].scale;
    _rootLayer.frame = self.view.bounds;
    
    //添加6个layer
    [self addLayer:@[@0, @0, @50, @0, @0, @0, @0]];
    [self addLayer:@[@0, @0, @(-50), @(M_PI), @0, @0, @0]];
    [self addLayer:@[@(-50), @0, @0, @(-M_PI_2), @0, @1, @0]];
    [self addLayer:@[@50, @0, @0, @(M_PI_2), @0, @1, @0]];
    [self addLayer:@[@0, @(-50), @0, @(-M_PI_2), @1, @0, @0]];
    [self addLayer:@[@0, @50, @0, @(M_PI_2), @1, @0, @0]];
    
    
    //主 layer 3D转换
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/700;
    //在X轴上做一个20度的小旋转
    
    transform = CATransform3DRotate(transform, M_PI / 9, 1, 0, 0);
    
    _rootLayer.sublayerTransform = transform;
    [self.view.layer addSublayer:_rootLayer];
    
    //动画 自动旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.rotation.y"];
    animation.toValue = [NSNumber numberWithFloat:2*M_PI];
    animation.duration = 3.0;
    //无限循环
    animation.repeatCount = HUGE_VALF;
    [_rootLayer addAnimation:animation forKey:@"rotation"];
    
    
}

- (void)addLayer:(NSArray *) params{
    CAGradientLayer *gradienLayer = [CAGradientLayer layer];
    
    gradienLayer.contentsScale = [UIScreen mainScreen].scale;
    gradienLayer.bounds = CGRectMake(0, 0, 100, 100);
    gradienLayer.position = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    gradienLayer.colors = @[(id)[UIColor grayColor].CGColor,(id)[UIColor grayColor].CGColor];
    gradienLayer.locations = @[@0,@1];
    gradienLayer.startPoint = CGPointMake(0, 0);
    gradienLayer.endPoint = CGPointMake(0, 1);
    
    CATransform3D tranform = CATransform3DMakeTranslation([[params objectAtIndex:0] floatValue], [[params objectAtIndex:1] floatValue], [[params objectAtIndex:2] floatValue]);
    
    tranform = CATransform3DRotate(tranform, [[params objectAtIndex:3] floatValue], [[params objectAtIndex:4] floatValue], [[params objectAtIndex:5] floatValue],
                                   [[params objectAtIndex:6] floatValue]);
    
    gradienLayer.transform = tranform;
    
    [_rootLayer addSublayer:gradienLayer];
    
}



@end
