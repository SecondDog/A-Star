//
//  DDCollection.h
//  A_Star
//
//  Created by bliss_ddo on 14-8-18.
//  Copyright (c) 2014年 SELF_PRACTICE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIIndexButton.h"
@interface DDCollection : NSObject
{
    NSMutableArray * bufferArr;
}
-(void)insertNode:(UIIndexButton*)btn;
-(id)popBestNodeAndRemove;
-(BOOL)isEmpty;
-(BOOL)isContainObject:(UIIndexButton*)btn;
@end
