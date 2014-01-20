//
//  TWaitView.m
//  Trends
//
//  Created by Travis on 13-11-12.
//  Copyright (c) 2013年 AVOSCloud. All rights reserved.
//

#import "TWaitView.h"

@interface TWaitView(){
    NSTimer *timer;

}
@property(nonatomic,retain) NSMutableArray *circles;
@property(nonatomic,retain) UIColor *color;
@end

@implementation TWaitView

- (id)initWithFrame:(CGRect)frame
{
    float width=frame.size.height=frame.size.width;
    self = [super initWithFrame:frame];
    if (self) {
        self.color=[UIColor whiteColor];
        self.circles=[NSMutableArray arrayWithCapacity:9];
        float gap=0.15;
        float w=width*(1.0-gap*2.0)/3.0;
        for (int i=0; i<9; i++) {
            CAShapeLayer *layer=[CAShapeLayer layer];
            UIBezierPath *ballBezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(i%3*(w+width*gap), i/3*(w+width*gap), w, w)];
            
            layer.path=ballBezierPath.CGPath;
            layer.strokeColor=self.color.CGColor;
            layer.fillColor=[UIColor clearColor].CGColor;
            [self.layer addSublayer:layer];
            [self.circles addObject:layer];
        }
        
        
    }
    return self;
}

-(void)setOpen:(BOOL)open{
    [self willChangeValueForKey:@"open"];
    _open=open;
    for (CAShapeLayer *layer in self.circles) {
        [layer removeAnimationForKey:@"fillColor"];
        
        if (open) {
            layer.fillColor=layer.strokeColor;
        }else{
            layer.fillColor=[UIColor clearColor].CGColor;
        }
    }
    [self didChangeValueForKey:@"open"];
}

-(void)tick:(NSTimer*)timer{
    CABasicAnimation *fillColorAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    fillColorAnimation.duration = 0.25f;
    if (self.open) {
        fillColorAnimation.fromValue = (id)[self.color CGColor];
        fillColorAnimation.toValue = (id)[[UIColor clearColor] CGColor];
    }else{
        fillColorAnimation.fromValue = (id)[[UIColor clearColor] CGColor];
        fillColorAnimation.toValue = (id)[self.color CGColor];
    }
    fillColorAnimation.autoreverses = YES;
    
    int random=arc4random()%self.circles.count;
    CAShapeLayer *layer=self.circles[random];
    
    [layer addAnimation:fillColorAnimation forKey:@"fillColor"];
}

-(void)wait:(BOOL)waitOrNot{
    static int c=0;
    static BOOL animate=NO;
    if (waitOrNot) {
        c=c+1;
    }else{
        c=c-1;
    }
    
    BOOL stat=(c>0);
    
    if (stat!=animate) {
        animate=stat;
        if (animate) {
            timer=[NSTimer scheduledTimerWithTimeInterval:0.35 target:self selector:@selector(tick:) userInfo:Nil repeats:YES];
            
        }else{
            [timer invalidate];
            timer=Nil;
            self.open=_open;
        }
    }
    
}

@end
