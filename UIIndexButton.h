//
//  UIIndexButton.h
//  A_Star
//
//  Created by bliss_ddo on 14-8-18.
//  Copyright (c) 2014年 SELF_PRACTICE. All rights reserved.
//

#import <UIKit/UIKit.h>
#define WIDH 40.0

typedef enum:NSInteger {
    NodeTypeNormal,
    NodeTypeStart,
    NodeTypeEnd,
    NodeTypeBlock,
}NodeType;

@interface UIIndexButton : UIButton

-(id)initWithXpath:(NSInteger)xp andYpath:(NSInteger)yPath;


@property (nonatomic,assign)NSInteger PathX;
@property (nonatomic,assign)NSInteger PathY;
@property (nonatomic,assign)double G_ValueCost;
@property (nonatomic,assign)double H_ValueCost;
@property (nonatomic,assign)double F_ValueCost;
@property (nonatomic,retain)UIIndexButton * parentNode;

@property (nonatomic,assign)NodeType nodeType;

//-(double)caculate_GValue:(UIIndexButton*)pNode;
-(double)caculate_HValue:(UIIndexButton*)pNode;
-(BOOL)checkIsEqualToNode:(UIIndexButton*)pNode;

@end
