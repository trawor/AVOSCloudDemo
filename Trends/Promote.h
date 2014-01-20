//
//  Promote.h
//  Trends
//
//  Created by Travis on 13-11-11.
//  Copyright (c) 2013年 AVOSCloud. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface Promote : AVObject<AVSubclassing>

@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *link;
@property(nonatomic,retain) AVFile *thumb;

+(void)getWithCallback:(AVArrayResultBlock)callback;
@end
