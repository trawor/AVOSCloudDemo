//
//  TPostC.m
//  Trends
//
//  Created by Travis on 13-11-12.
//  Copyright (c) 2013年 AVOSCloud. All rights reserved.
//

#import "TPostC.h"
#import <UIImageView+WebCache.h>
#import <DDProgressView/DDProgressView.h>

#import <UMengSocial/UMSocial.h>

@interface TPostC ()
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *authorLb;
@property (weak, nonatomic) IBOutlet UIImageView *thumb;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation TPostC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.content.text=self.post.text;
    self.content.scrollEnabled=NO;
    
    self.titleLb.text=self.post.title;
    self.authorLb.text=self.post.author;
    [self.typeBtn setTitle:[NSString stringWithFormat:@"< %@ >",self.post.type] forState:UIControlStateNormal];
    
    [self layoutContentViews];
    
    CGRect pf=self.thumb.frame;
    
    NSString *url=[self.post.thumb url];
    url=[url stringByAppendingFormat:@"?imageView/2/w/%.0f", pf.size.width*2];
    
    DDProgressView *pv=[[DDProgressView alloc] initWithFrame:CGRectMake(0, (pf.size.height-22)/2, pf.size.width, pf.size.height)];
    [self.thumb addSubview:pv];
    
    __weak typeof(self) ws=self;
    
    [self.thumb setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageLowPriority progress:^(NSUInteger receivedSize, long long expectedSize) {
        [pv setProgress:receivedSize*1.0/expectedSize];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [pv removeFromSuperview];
        
        [ws layoutContentViews];
        
    }];

    
}

-(void)layoutContentViews{
    CGRect f=self.thumb.frame;
    
    float w=f.size.width;
    
    float r=self.thumb.image.size.width/self.thumb.image.size.height;
    
    f.size.height=MAX(130, w/r);
    self.thumb.frame=f;
    
    
    CGRect f2=self.content.frame;
    
    CGSize newSize = [self.content.text
                      
                      sizeWithFont:self.content.font
                      
                      constrainedToSize:CGSizeMake(f2.size.width,9999)
                      
                      lineBreakMode:0];
    
    f2.size.height=newSize.height;
    f2.origin.y=f.origin.y+f.size.height+10;
    self.content.frame=f2;
    
    self.scrollView.contentSize=CGSizeMake(30, f2.origin.y+f2.size.height);
    
}

- (IBAction)onShare:(id)sender {
    //NSString *UMShareToCopyURL=@"CopyURL";
    
    [UMSocialSnsService
     presentSnsIconSheetView:self
     appKey:@"507fcab25270157b37000010"
     shareText:self.titleLb.text
     shareImage:self.thumb.image
     shareToSnsNames:@[
                       UMShareToSina,
                       UMShareToWechatSession,
                       UMShareToWechatTimeline,
                       UMShareToQQ,
                       UMShareToEmail,
                       UMShareToSms]
     delegate:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [AVAnalytics beginLogPageView:@"文章"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [AVAnalytics endLogPageView:@"文章"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
