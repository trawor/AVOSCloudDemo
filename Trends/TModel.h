//
//  TModel.h
//  Trends
//
//  Created by Travis on 13-11-11.
//  Copyright (c) 2013年 AVOSCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

#import "Promote.h"
#import "Post.h"

@interface TModel : NSObject

+(TModel*)shared;
+(int)osVersion;
+(BOOL)is4Inch;
@end


#define model [TModel shared]