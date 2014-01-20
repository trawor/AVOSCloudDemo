//
//  Promote.m
//  Trends
//
//  Created by Travis on 13-11-11.
//  Copyright (c) 2013年 AVOSCloud. All rights reserved.
//

#import "Promote.h"

@implementation Promote
@dynamic thumb,title,link;
+(NSString*)parseClassName{
    return @"Promote";
}

+(void)getWithCallback:(AVArrayResultBlock)callback{
    
    AVQuery *q= [self query];
    q.cachePolicy=kAVCachePolicyCacheThenNetwork;
    q.maxCacheAge=24*3600;
    q.limit=3;
    
    [q addDescendingOrder:@"updatedAt"];
    
    [q findObjectsInBackgroundWithBlock:callback];
}

@end
