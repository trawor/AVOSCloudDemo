//
//  TMainC.m
//  Trends
//
//  Created by Travis on 13-11-11.
//  Copyright (c) 2013年 AVOSCloud. All rights reserved.
//

#import "TMainC.h"
#import "TMainTableC.h"
#import <StyledPageControl/StyledPageControl.h>
#import <DDProgressView.h>

@interface TMainC ()<UIScrollViewDelegate>{
    float rowHeight;
}
@property (weak, nonatomic) IBOutlet UIScrollView *promoteView;
@property (weak, nonatomic) IBOutlet UILabel *promoteTitle;
@property (retain, nonatomic) IBOutlet TMainTableC *tableC;

@property (retain, nonatomic) NSArray *promtes;
@property (weak, nonatomic) IBOutlet StyledPageControl *pageControl;
@end

@implementation TMainC

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static NSInteger previousPage = 0;
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    if (previousPage != page) {
        previousPage = page;
        Promote *pro=self.promtes[page];
        self.promoteTitle.text=pro.title;
        [self.pageControl setCurrentPage:page];
    }
}

-(void)loadPromotes{
    //[[TNavView shared] wait:YES];
    
    __weak TMainC *ws=self;
    __block CGRect pf=self.promoteView.bounds;
    [Promote getWithCallback:^(NSArray *objects, NSError *error) {
        for (int i=0; i<objects.count; i++) {
            [[ws.promoteView viewWithTag:1000+i] removeFromSuperview];
            
            pf.origin.x=i*pf.size.width;
            Promote *pro=objects[i];
            UIImageView *imgv=[[UIImageView alloc] initWithFrame:pf];
            imgv.tag=1000+i;
            NSString *url=[pro.thumb url];
            url=[url stringByAppendingFormat:@"?imageView/1/w/%.0f/h/%.0f", pf.size.width*2,pf.size.height*2];
            
            DDProgressView *pv=[[DDProgressView alloc] initWithFrame:CGRectMake(50, (pf.size.height-22)/2, pf.size.width-100, pf.size.height)];
            
            pv.innerColor=pv.outerColor=[UIColor whiteColor];
            
            [imgv addSubview:pv];
            [imgv setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageLowPriority progress:^(NSUInteger receivedSize, long long expectedSize) {
                [pv setProgress:receivedSize*1.0/expectedSize];
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                [pv removeFromSuperview];
            }];
            
            [ws.promoteView addSubview:imgv];
        }
        ws.promoteView.contentSize=CGSizeMake(pf.size.width+pf.origin.x, 10);
        
        Promote *pro=objects[0];
        ws.promoteTitle.text=pro.title;
        ws.promtes=objects;
        ws.pageControl.numberOfPages=objects.count;
        [ws.pageControl setCurrentPage:0];
        
        ws.view.hidden=NO;
        //[[TNavView shared] wait:NO];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.hidden=YES;
    self.promoteView.delegate=self;
    
    TMainTableC *tc=[[TMainTableC alloc] init];
    tc.date=[NSDate date];
    
    [self.view addSubview:tc.view];
    self.tableC=tc;
    [self addChildViewController:tc];
    
    CGRect pf=self.promoteView.bounds;
    
    StyledPageControl *pageControl = [[StyledPageControl alloc] initWithFrame:CGRectMake(pf.size.width-60, pf.size.height-15, 60, 10)];
    pageControl.diameter=7;
    pageControl.gapWidth=4;
    //pageControl.strokeWidth=2;
    
    [pageControl setPageControlStyle:PageControlStyleDefault];
    
    [pageControl setStrokeNormalColor:[UIColor clearColor]];
    [pageControl setCoreNormalColor:[UIColor colorWithWhite:1 alpha:0.8]];
    
    [pageControl setStrokeSelectedColor:[UIColor colorWithWhite:1 alpha:0.8]];
    [pageControl setCoreSelectedColor:[UIColor clearColor]];
    
    [self.view addSubview:pageControl];
    self.pageControl=pageControl;
    
    
    
    UISwipeGestureRecognizer *swip=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwip:)];
    [self.view addGestureRecognizer:swip];
    
    swip=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwip:)];
    swip.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swip];
    
    [self loadPromotes];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (rowHeight==0) {
        CGRect f=self.navigationController.view.frame;
        
        f.origin.y=self.promoteView.frame.size.height;
        
        CGRect navF=[TNavView shared].frame;
        
        f.size.height-=f.origin.y+navF.size.height+navF.origin.y+20;
        
        self.tableC.view.frame=f;
        
        rowHeight=f.size.height/3;
        self.tableC.tableView.rowHeight=rowHeight;
    }
    [AVAnalytics beginLogPageView:@"首页"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [AVAnalytics endLogPageView:@"首页"];
}

-(void)onSwip:(UISwipeGestureRecognizer*)swip{
    TMainTableC *tc=[[TMainTableC alloc] init];
    tc.tableView.rowHeight=rowHeight;
    
    NSDate *date=[TNavView shared].date;
    NSDate *newdate=nil;
    
    CGRect f=self.tableC.view.frame;
    CGRect f2=self.tableC.view.frame;
    
    if (swip.direction==UISwipeGestureRecognizerDirectionLeft) {
        newdate=[date dateByAddingTimeInterval:24*3600];
        f.origin.x=f.size.width;
        f2.origin.x=-f.size.width;
    }else if (swip.direction==UISwipeGestureRecognizerDirectionRight) {
        newdate=[date dateByAddingTimeInterval:-24*3600];
        f.origin.x=-f.size.width;
        f2.origin.x=f.size.width;
    }
    tc.view.frame=f;
    tc.date=newdate;
    [TNavView shared].date=newdate;
    
    [tc viewWillAppear:NO];
    [self.view addSubview:tc.view];
    
    [UIView animateWithDuration:0.25 animations:^{
        tc.view.frame=self.tableC.view.frame;
        self.tableC.view.frame=f2;
    } completion:^(BOOL finished) {
        [self.tableC.view removeFromSuperview];
        [self.tableC removeFromParentViewController];
        self.tableC=tc;
        [self addChildViewController:tc];
    }];
    
    
}

@end
