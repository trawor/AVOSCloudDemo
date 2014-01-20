//
//  TMainTableC.m
//  Trends
//
//  Created by Travis on 13-11-11.
//  Copyright (c) 2013年 AVOSCloud. All rights reserved.
//

#import "TMainTableC.h"
#import "TPostC.h"
#import "TNavView.h"
#import "TModel.h"
#import "TWaitView.h"
@interface MainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UIImageView *thumb;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UIImageView *bg;
@end

@implementation MainCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        UIImageView *bgv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"part_choose"]];
        [[self contentView] addSubview:bgv];
        self.bg=bgv;
        
        self.backgroundColor=self.contentView.backgroundColor=[UIColor clearColor];
        
        self.opaque=NO;
        
        UILabel *lb=[[UILabel alloc] initWithFrame:CGRectMake(87, 14, 222, 21)];
        lb.font=[UIFont boldSystemFontOfSize:15];
        lb.backgroundColor=[UIColor clearColor];
        lb.textColor=[UIColor whiteColor];
        [self.contentView addSubview:lb];
        self.title=lb;
        
        lb=[[UILabel alloc] initWithFrame:CGRectMake(87, 35, 222, 57)];
        lb.font=[UIFont systemFontOfSize:13];
        lb.backgroundColor=[UIColor clearColor];
        lb.textColor=[UIColor grayColor];
        [self.contentView addSubview:lb];
        self.text=lb;
        
        UIImageView *imgv=[[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 64, 88)];
        [self.contentView addSubview:imgv];
        self.thumb=imgv;
        
        if (![TModel is4Inch]) {
            CGRect f=self.title.frame;
            f.origin.y=7;
            self.title.frame=f;
            
            f=self.text.frame;
            f.size.height=40;
            f.origin.y=30;
            self.text.frame=f;
            self.text.numberOfLines=2;
            
            self.thumb.frame=CGRectMake(15, 9, 64, 64);
        }
        
    }
    return self;
}

-(void)awakeFromNib{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

@end

@interface TMainTableC (){
    TWaitView *_wait;
}

@end

@implementation TMainTableC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.tableView.bounces=NO;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //[self.tableView registerNib:[UINib nibWithNibName:@"Views" bundle:Nil] forCellReuseIdentifier:@"MainCell"];
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.backgroundView=[UIView new];
    self.tableView.autoresizingMask=UIViewAutoresizingFlexibleWidth;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.posts==nil) {
        [self loadPost];
    }
}

-(void)loadPost{
    
    TWaitView *waitView=[[TWaitView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    
    CGPoint p=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    waitView.center=p;
    [waitView wait:YES];
    [self.view addSubview:waitView];
    
    __weak TMainTableC *ws=self;
    [Post getPostByDate:self.date callback:^(NSArray *objects, NSError *error) {
        [waitView removeFromSuperview];
        ws.posts=objects;
        [ws.tableView reloadData];
    }];
}

#pragma mark - Table view data source

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.rowHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MainCell";
    MainCell *cell = (MainCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==Nil) {
        cell=[[MainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
//    if (indexPath.row==self.posts.count-1) {
//        cell.sepLine.hidden=YES;
//    }else{
//        cell.sepLine.hidden=NO;
//    }
    
    if (indexPath.row%2) {
        cell.bg.hidden=NO;
    }else{
        cell.bg.hidden=YES;
    }
    
    Post *p=[self.posts objectAtIndex:indexPath.row];
    
    cell.title.text=p.title;
    cell.text.text=p.text;
    cell.type.text=p.type;
    
    NSString *thumbUrl=[[p.thumb url] stringByAppendingFormat:@"?imageView/1/w/%.0f/h/%.0f", cell.thumb.frame.size.width*2,cell.thumb.frame.size.height*2];
    
    [cell.thumb setImageWithURL:[NSURL URLWithString:thumbUrl] placeholderImage:nil];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TPostC *pc= [[UIStoryboard storyboardWithName:@"iPhone" bundle:Nil] instantiateViewControllerWithIdentifier:@"PostC"];
    pc.post=self.posts[indexPath.row];
    [self.parentViewController.navigationController pushViewController:pc animated:YES];
    
}



@end
