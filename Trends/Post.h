//
//  Post.h
//  Trends
//
//  Created by Travis on 13-11-11.
//  Copyright (c) 2013年 AVOSCloud. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface Post : AVObject<AVSubclassing>
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, copy) NSString *link;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *author;
@property(nonatomic, copy) AVFile *thumb;

+(void)getPostByDate:(NSDate*)date callback:(AVArrayResultBlock)callback;
@end
