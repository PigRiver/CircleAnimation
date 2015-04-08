//
//  BZDCircleGroupLayer.m
//  BZDCircleAnimation
//
//  Created by Bruce on 15-4-8.
//  Copyright (c) 2015年 Bruce Zhu. All rights reserved.
//

#import "BZDCircleGroupLayer.h"
#import "BZDCircleLayer.h"

#import <math.h>
#import <UIKit/UIKit.h>//bruce test

@interface BZDCircleGroupLayer()

@property (nonatomic, strong) NSMutableArray *layerList;
@property (nonatomic) int timeModel;

@end

@implementation BZDCircleGroupLayer

- (id)init {
    self = [super init];
    if (self) {
        self.timeModel = 0;
        [self configCircles];
    }
    [self performSelector:@selector(doAnimation) withObject:nil afterDelay:1];
    
    return self;
}

- (void)configCircles {
    self.layerList = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < CIRCLE_COUNT; i++) {
        @autoreleasepool {
            BZDCircleLayer *layer = [[BZDCircleLayer alloc] init];
            if (i % 3 == 0 ) {
                layer.fillColor = [UIColor redColor].CGColor;
            } else if (i % 3 == 1 ) {
                layer.fillColor = [UIColor cyanColor].CGColor;
            } else if (i % 3 == 2 ) {
                layer.fillColor = [UIColor orangeColor].CGColor;
            }
            layer.position = [self calculatePositionWithIndex:(CGFloat)i];
            [self addSublayer:layer];
            [self.layerList addObject:layer];
        }
    }
}

- (CGPoint)calculatePositionWithIndex:(CGFloat)index {
    CGPoint centerPoint = CGPointZero;
    CGFloat xPosition = CIRCLE_GROUP_RADIUS * sin((CGFloat)index / CIRCLE_COUNT * M_PI * 2);
    CGFloat yPosition = CIRCLE_GROUP_RADIUS * cos((CGFloat)index / CIRCLE_COUNT * M_PI * 2);
    
    return CGPointMake(centerPoint.x + xPosition, centerPoint.y - yPosition);
}

- (void)doAnimation {
    [self doCircleAnimation];
    [self doMoveAnimation];
    [NSTimer scheduledTimerWithTimeInterval:POINT_ANIMATION_WAIT + (CIRCLE_COUNT * DURATION_TIME) target:self
                                   selector:@selector(doMoveAnimation) userInfo:nil repeats:YES];
    
}

- (void)doMoveAnimation {
    self.timeModel = self.timeModel % 2 + 1;
    
    [self.layerList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CALayer *layer = obj;
        dispatch_time_t afterTime = dispatch_time(DISPATCH_TIME_NOW, (idx * DURATION_TIME * NSEC_PER_SEC));
        dispatch_after(afterTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [CATransaction begin];
            [CATransaction setAnimationDuration:ANIMATION_TIME];
            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            layer.position = [self calculatePositionWithIndex:((int)idx + 7.5 * self.timeModel)];
            
            [CATransaction commit];
        });

    }];
}

- (void)doCircleAnimation {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.fromValue = @0;
    anim.toValue = @(M_PI * 2);
    anim.repeatCount = MAX_TIME;
    anim.duration = CIRCLE_ANIMATION_TIME;
    [self addAnimation:anim forKey:@"animRotation"];
}

@end
