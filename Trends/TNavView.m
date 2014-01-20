//
//  TNavView.m
//  Trends
//
//  Created by Travis on 13-11-11.
//  Copyright (c) 2013年 AVOSCloud. All rights reserved.
//

#import "TNavView.h"
#import "TWaitView.h"
@interface TNavView(){
    UILabel *dateLb,*weekLb,*yearLb;
    TWaitView *_wait;
    
    BOOL open;
}
@end

@implementation TNavView

+(TNavView*)shared{
    static dispatch_once_t once;
    static TNavView * sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (id)init
{
    self = [super initWithFrame:CGRectMake(0, -2, 320, 46)];
    if (self) {
        UIImageView *bg=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar"]];
        [self addSubview:bg];
        
        UIImageView *logo=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        logo.center=CGPointMake(58, 23);
        [self addSubview:logo];
        
        UIImageView *time=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Calendar"]];
        time.center=CGPointMake(123, 23);
        [self addSubview:time];

        
        dateLb=[[UILabel alloc] initWithFrame:CGRectMake(135, 13, 20, 14)];
        dateLb.font=[UIFont fontWithName:@"AvenirNext-Bold" size:14];
        
        [self addSubview:dateLb];
        
        
        weekLb=[[UILabel alloc] initWithFrame:CGRectMake(158, 14, 87, 13)];
        weekLb.font=[UIFont fontWithName:@"AvenirNext-BoldItalic" size:11];
        [self addSubview:weekLb];
        
        yearLb=[[UILabel alloc] initWithFrame:CGRectMake(135, 27, 90, 11)];
        yearLb.font=[UIFont fontWithName:@"Euphemia UCAS" size:10];
        
        dateLb.textColor=weekLb.textColor=yearLb.textColor=[UIColor whiteColor];
        
        [self addSubview:yearLb];
        
        self.date=[NSDate date];
        
//        _wait=[[TWaitView alloc] initWithFrame:CGRectMake(277, 12, 25, 25)];
//        [self addSubview:_wait];
//        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.contentMode=UIViewContentModeCenter;
        
        [btn setFrame:CGRectMake(280, 15, 24, 22)];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_blank"] forState:UIControlStateNormal];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_blank_choose"] forState:UIControlStateHighlighted];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_blank_choose"] forState:UIControlStateSelected];
        
        
        [btn addTarget:self action:@selector(switchOpen:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
    }
    return self;
}

-(void)switchOpen:(UIButton*)btn{
    btn.selected=!btn.selected;
    
    
    
}

-(void)switchOpen{
    _wait.open=!_wait.open;
    if (_wait.open) {
        
    }else{
        
    }
}


-(void)wait:(BOOL)waitOrNot{
    [_wait wait:waitOrNot];
}

-(void)setDate:(NSDate *)date{
    _date=date;
    
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd"];
    
    dateLb.text=[df stringFromDate:date];
    
    [df setDateFormat:@"yyyy/MM"];
    yearLb.text=[df stringFromDate:date];
    
    
    NSCalendar *gregorian=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    NSInteger week=[components weekday];
    
    switch (week) {
        case 1:
            weekLb.text=@"Sunday";
            break;
        case 2:
            weekLb.text=@"Monday";
            break;
        case 3:
            weekLb.text=@"Tuesday";
            break;
        case 4:
            weekLb.text=@"Wednesday";
            break;
        case 5:
            weekLb.text=@"Thursday";
            break;
        case 6:
            weekLb.text=@"Friday";
            break;
        case 7:
            weekLb.text=@"Saturday";
        
    }
    
}

@end
