//
//  UIAStarView.h
//  A_Star
//
//  Created by bliss_ddo on 14-8-18.
//  Copyright (c) 2014年 SELF_PRACTICE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIIndexButton.h"
#import "NSMutableArray+index.h"
#import "DDCollection.h"
@interface UIAStarView : UIScrollView
{
    NSInteger maxX;
    NSInteger maxY;
    
    DDCollection * OpenTable;
    DDCollection * CloseTable;
    
}
-(id)initWithFrame:(CGRect)frame XCount:(NSInteger)xcount andYCount:(NSInteger)ycount;


@property (nonatomic,retain)NSMutableArray * ArrayOfAllNodes;
@property (nonatomic,retain)UIIndexButton * startBtn;
@property (nonatomic,retain)UIIndexButton * endBtn;

-(void)randomStartPoint;
-(void)randomEndPoint;
-(void)randomBlockWithCount:(NSInteger)count;

-(void)searchBestPath;

-(NSMutableArray*)nebighourNodeOfNode:(UIIndexButton*)btn;

@end
