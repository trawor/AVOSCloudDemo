//
//  Post.m
//  Trends
//
//  Created by Travis on 13-11-11.
//  Copyright (c) 2013年 AVOSCloud. All rights reserved.
//

#import "Post.h"

@implementation Post
@dynamic title,link,thumb,text,type;

+(NSString*)parseClassName{
    return @"Post";
}

+(void)getPostByDate:(NSDate*)date callback:(AVArrayResultBlock)callback{
    if (date==nil) {
        callback(nil,nil);
        return;
    }
    static NSDateFormatter *df=nil;
    
    if (df==nil) {
        df=[[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyyMMdd"];
    }
    
    AVQuery *q= [Post query];
    q.cachePolicy=kAVCachePolicyCacheElseNetwork;
    q.limit=3;
    //[q whereKey:@"date" equalTo:[df stringFromDate:date]];
    
    
    [q setSkip:arc4random()%3];
    
    [q findObjectsInBackgroundWithBlock:callback];
}

@end
