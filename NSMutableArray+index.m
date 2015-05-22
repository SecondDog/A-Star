//
//  NSMutableArray+index.m
//  A_Star
//
//  Created by bliss_ddo on 14-8-18.
//  Copyright (c) 2014年 SELF_PRACTICE. All rights reserved.
//

#import "NSMutableArray+index.h"

@implementation NSMutableArray (index)
-(UIIndexButton*)objectAtIndex:(NSInteger)x withIndex:(NSInteger)y
{
    NSMutableArray * arr = [self objectAtIndex:x];
    UIIndexButton * btn = [arr objectAtIndex:y];
    return btn;
}

@end
