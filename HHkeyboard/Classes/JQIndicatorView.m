//
//  JQIndicatorView.m
//  JQIndicatorViewDemo
//
//  Created by James on 15/7/21.
//  Copyright (c) 2015年 JQ. All rights reserved.
//

#import "JQIndicatorView.h"

#define JQIndicatorDefaultTintColor [UIColor colorWithRed:0.049 green:0.849 blue:1.000 alpha:1.000]
#define JQIndicatorDefaultSize CGSizeMake(60,60)

@interface JQIndicatorView ()

@property CALayer *lineLayer;
@property JQIndicatorType type;
@property CGSize size;
@property UIColor *loadingTintColor;

- (void)setToNormalState;
- (void)setToFadeOutState;
- (void)fadeOutWithAnimation:(BOOL)animated;

@end

@implementation JQIndicatorView

- (instancetype)initWithType:(JQIndicatorType)type{
    return [self initWithType:type tintColor:JQIndicatorDefaultTintColor];
}

- (instancetype)initWithType:(JQIndicatorType)type tintColor:(UIColor *)color{
    return [self initWithType:type tintColor:color size:JQIndicatorDefaultSize];
}

- (instancetype)initWithType:(JQIndicatorType)type tintColor:(UIColor *)color size:(CGSize)size{
    if (self = [super init]) {
        self.type = type;
        self.loadingTintColor = color;
        self.size = size;
    }
    
    return self;
}

- (void)configAnimationAtLayer:(CALayer *)layer withTintColor:(UIColor *)color size:(CGSize)size{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, size.width, size.height);
    replicatorLayer.position = CGPointMake(0,0);
    replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    [layer addSublayer:replicatorLayer];
    [self addCyclingLineAnimationLayerAtLayer:replicatorLayer withTintColor:color size:size];
    
    NSInteger numOfDot = 6;
    replicatorLayer.instanceCount = numOfDot;
    CGFloat angle = -(M_PI * (6 / 15.0) * 2)/numOfDot;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    replicatorLayer.instanceDelay = 1.5/numOfDot;
}

- (void)addCyclingLineAnimationLayerAtLayer:(CALayer *)layer withTintColor:(UIColor *)color size:(CGSize)size{
    self.lineLayer = [CALayer layer];
    self.lineLayer.bounds = CGRectMake(0, 0, 3, size.width/6);
    self.lineLayer.position = CGPointMake(size.width/2, 5);
    self.lineLayer.backgroundColor = color.CGColor;
    self.lineLayer.opacity = 0.9;
    self.lineLayer.cornerRadius = 1.5;
    self.lineLayer.shouldRasterize = YES;
    self.lineLayer.rasterizationScale = [UIScreen mainScreen].scale;
    
    [layer addSublayer:self.lineLayer];
}

- (void)removeAnimation{
    [self.lineLayer removeAnimationForKey:@"animation"];
}

@end
