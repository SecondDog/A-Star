//
//  DDCollection.m
//  A_Star
//
//  Created by bliss_ddo on 14-8-18.
//  Copyright (c) 2014年 SELF_PRACTICE. All rights reserved.
//

#import "DDCollection.h"
#import "UIIndexButton.h"
@implementation DDCollection
-(id)init
{
    self = [super init];
    if (self) {
        bufferArr = [[NSMutableArray alloc]init];
    }
    return self;
}
-(id)popBestNodeAndRemove
{
    if (bufferArr.count==0) {
        return nil;
    }
    UIIndexButton * btn = [bufferArr lastObject];
    [bufferArr removeLastObject];
    return btn;
}
-(BOOL)isEmpty
{
    return bufferArr.count==0;
}
-(BOOL)isContainObject:(UIIndexButton*)btn
{
    BOOL isContain = NO;
    if (bufferArr.count==0) {
        return isContain;
    }
    for (int i=0; i<bufferArr.count; i++) {
        UIIndexButton * abtn = [bufferArr objectAtIndex:i];
        if ([abtn checkIsEqualToNode:btn]) {
            isContain = YES;
            break;
        }
    }
    return isContain;
}
-(void)insertNode:(UIIndexButton*)btn
{
    if ([self isContainObject:btn]) {
        return;
    }
    [bufferArr addObject:btn];
    [self sort];
}
-(void)sort
{
    if (bufferArr.count<=1) {
        return;
    }
//    for (int i=0; i<bufferArr.count; i++) {
//        UIIndexButton * btn1 = [bufferArr objectAtIndexedSubscript:i];
//        for (int j=0; j>i; j++) {
//            UIIndexButton * btn2 = [bufferArr objectAtIndexedSubscript:j];
//            if (btn1.F_ValueCost < btn2.F_ValueCost) {
//                [bufferArr exchangeObjectAtIndex:i withObjectAtIndex:j];
//            }
//        }
//    }
    [bufferArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        UIIndexButton * btn1 = (UIIndexButton*)obj1;
        UIIndexButton * btn2 = (UIIndexButton*)obj2;
        if (btn1.F_ValueCost >btn2.F_ValueCost) {
            return NSOrderedAscending;
        }else if(btn1.F_ValueCost<btn2.F_ValueCost){
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
//    NSLog(@"%@",bufferArr);
    
    
    
}
@end
