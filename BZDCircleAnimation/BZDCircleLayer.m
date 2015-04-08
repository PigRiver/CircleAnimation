//
//  BZDCircleLayer.m
//  BZDCircleAnimation
//
//  Created by Bruce on 15-4-5.
//  Copyright (c) 2015年 Bruce Zhu. All rights reserved.
//

#import "BZDCircleLayer.h"
#import <UIKit/UIKit.h>

@implementation BZDCircleLayer

- (id)init {
    self = [super init];
    if (self) {
        [self configToCircle];
    }
    
    return self;
}

- (void)configToCircle {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, nil, 0, 0, CIRCLE_RADIUS, 0, M_PI * 2, YES);
    self.path = path;
    self.fillColor = [UIColor blueColor].CGColor;
    CGPathRelease(path);
}

@end
