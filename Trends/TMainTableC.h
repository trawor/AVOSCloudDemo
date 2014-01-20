//
//  TMainTableC.h
//  Trends
//
//  Created by Travis on 13-11-11.
//  Copyright (c) 2013年 AVOSCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TModel.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface TMainTableC : UITableViewController
@property(nonatomic,retain) NSArray *posts;
@property(nonatomic,retain) NSDate *date;
@end
