//
//  TWaitView.h
//  Trends
//
//  Created by Travis on 13-11-12.
//  Copyright (c) 2013年 AVOSCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWaitView : UIView
@property(nonatomic,assign) BOOL open;

-(void)wait:(BOOL)waitOrNot;



@end
