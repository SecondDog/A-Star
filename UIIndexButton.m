//
//  UIIndexButton.m
//  A_Star
//
//  Created by bliss_ddo on 14-8-18.
//  Copyright (c) 2014年 SELF_PRACTICE. All rights reserved.
//

#import "UIIndexButton.h"

@implementation UIIndexButton


@synthesize PathX,PathY,G_ValueCost,H_ValueCost,parentNode;
@synthesize nodeType;


-(id)initWithXpath:(NSInteger)xp andYpath:(NSInteger)yPath
{
    self = [super init];
    if (self) {
        CGFloat originalX = xp*WIDH;
        CGFloat originalY = yPath*WIDH;
        CGFloat widthX = WIDH;
        CGFloat widthY = WIDH;
        self.PathX=xp;
        self.PathY=yPath;
        self.parentNode = nil;
        [self setFrame:CGRectMake(originalX, originalY, widthX, widthY)];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.layer.borderColor=[[UIColor grayColor]CGColor];
        self.layer.borderWidth = 4.0f;
        
    }
    return self;
}



-(double)caculate_HValue:(UIIndexButton*)pNode
{
    return fabs(pNode.PathX-self.PathX)+fabs(pNode.PathY-self.PathY);
}
-(BOOL)checkIsEqualToNode:(UIIndexButton*)pNode
{
    return (pNode.PathX == self.PathX)&&(pNode.PathY==self.PathY);
}
-(void)setNodeType:(NodeType)nodeType1
{
    nodeType = nodeType1;
    switch (nodeType) {
        case NodeTypeBlock:
            [self setBackgroundColor:[UIColor blackColor]];
            break;
        case NodeTypeStart:
            [self setBackgroundColor:[UIColor redColor]];
        case NodeTypeEnd:
            [self setBackgroundColor:[UIColor blueColor]];
        default:
            [self setBackgroundColor:[UIColor whiteColor]];
            break;
    }
    [self setNeedsDisplay];
    

}

@end
