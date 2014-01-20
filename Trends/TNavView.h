//
//  TNavView.h
//  Trends
//
//  Created by Travis on 13-11-11.
//  Copyright (c) 2013年 AVOSCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TNavView : UIView

@property(nonatomic,retain) NSDate *date;
+(TNavView*)shared;

//-(void)wait:(BOOL)waitOrNot;
@end
