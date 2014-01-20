//
//  TModel.m
//  Trends
//
//  Created by Travis on 13-11-11.
//  Copyright (c) 2013年 AVOSCloud. All rights reserved.
//

#import "TModel.h"

@implementation TModel

+(TModel*)shared{
    static dispatch_once_t once;
    static TModel * sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+(int)osVersion{
    static int verion=0;
    if (verion==0) {
        verion=[[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue];
    }
    return verion;
}
+(BOOL)is4Inch{
    return [[UIScreen mainScreen] bounds].size.height==568;
}
- (id)init
{
    self = [super init];
    if (self) {
        [Post registerSubclass];
        [Promote registerSubclass];
    }
    return self;
}

@end
