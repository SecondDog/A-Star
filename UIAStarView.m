//
//  UIAStarView.m
//  A_Star
//
//  Created by bliss_ddo on 14-8-18.
//  Copyright (c) 2014年 SELF_PRACTICE. All rights reserved.
//

#import "UIAStarView.h"



// rejown@gmail.com

@implementation UIAStarView
@synthesize ArrayOfAllNodes;
@synthesize startBtn,endBtn;

#define abigNumber 1234567.0

-(id)initWithFrame:(CGRect)frame XCount:(NSInteger)xcount andYCount:(NSInteger)ycount
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = xcount*WIDH;
        CGFloat height = ycount*WIDH;
        maxX = xcount;
        maxY = ycount;
        OpenTable = [[DDCollection alloc]init];
        CloseTable = [[DDCollection alloc]init];
        
        [self setContentSize:CGSizeMake(width, height)];
        ArrayOfAllNodes = [[NSMutableArray alloc]init];
        for (int i=0; i<xcount; i++) {
            NSMutableArray * arr = [NSMutableArray array];
            for (int j=0; j<ycount; j++) {
                UIIndexButton * btn = [[UIIndexButton alloc]initWithXpath:i andYpath:j];
                btn.nodeType = NodeTypeNormal;
                btn.H_ValueCost = abigNumber;
                btn.G_ValueCost = abigNumber;
                btn.F_ValueCost = btn.H_ValueCost+btn.G_ValueCost;
                [btn addTarget:self action:@selector(IndexButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [arr addObject:btn];
                [self addSubview:btn];
            }
            [ArrayOfAllNodes addObject:arr];
        }
    }
    return self;
}
-(NSMutableArray*)nebighourNodeOfNode:(UIIndexButton*)btn
{
    NSMutableArray * retArr = [NSMutableArray arrayWithCapacity:4];
    
    NSInteger upPathx = btn.PathX;
    NSInteger upPathY = btn.PathY-1;
    
    NSInteger downPathx = btn.PathX;
    NSInteger downPathy = btn.PathY+1;
    
    NSInteger leftPathx = btn.PathX-1;
    NSInteger leftPathy = btn.PathY;
    
    NSInteger rightPathx = btn.PathX+1;
    NSInteger rightPathy = btn.PathY;
    
    if (!(upPathY<0)) {
        UIIndexButton * btnUp = [self.ArrayOfAllNodes objectAtIndex:upPathx withIndex:upPathY];
        if (btnUp.nodeType!=NodeTypeBlock) {
            [retArr addObject:btnUp];
//            [btnUp setBackgroundColor:[UIColor yellowColor]];

        }
    }
    if (downPathy<maxY) {
        UIIndexButton * btnDown = [self.ArrayOfAllNodes objectAtIndex:downPathx withIndex:downPathy];
        if (btnDown.nodeType!=NodeTypeBlock) {
            [retArr addObject:btnDown];
//            [btnDown setBackgroundColor:[UIColor yellowColor]];

        }
    }
    if (!(leftPathx<0)) {
        UIIndexButton * btnLeft = [self.ArrayOfAllNodes objectAtIndex:leftPathx withIndex:leftPathy];
        if (btnLeft.nodeType!=NodeTypeBlock) {
            [retArr addObject:btnLeft];
//            [btnLeft setBackgroundColor:[UIColor yellowColor]];

        }
    }
    if (rightPathx<maxX) {
        UIIndexButton * btnRight = [self.ArrayOfAllNodes objectAtIndex:rightPathx withIndex:rightPathy];
        if (btnRight.nodeType!=NodeTypeBlock) {
            [retArr addObject:btnRight];
//            [btnRight setBackgroundColor:[UIColor yellowColor]];
        }
    }
    
    
    return retArr;
}

-(void)randomStartPoint
{
    NSInteger randomX = arc4random()%maxX;
    NSInteger randomY = arc4random()%maxY;
    UIIndexButton * btn = [self.ArrayOfAllNodes objectAtIndex:randomX withIndex:randomY];
//    UIIndexButton * btn = [self.ArrayOfAllNodes objectAtIndex:maxX-1 withIndex:maxY-1];
    if (btn.nodeType !=NodeTypeEnd) {
        btn.nodeType = NodeTypeStart;
        btn.parentNode=nil;
        btn.G_ValueCost =0;
        btn.H_ValueCost = [btn caculate_HValue:endBtn];
        btn.F_ValueCost = btn.G_ValueCost+btn.H_ValueCost;
        [btn setBackgroundColor:[UIColor redColor]];
        self.startBtn = btn;
        [self setNeedsDisplay];
        return;
    }else{
        [self randomStartPoint];
    }
}
-(void)randomEndPoint
{
    NSInteger randomX = arc4random()%maxX;
    NSInteger randomY = arc4random()%maxY;
    UIIndexButton * btn = [self.ArrayOfAllNodes objectAtIndex:randomX withIndex:randomY];
//    UIIndexButton * btn = [self.ArrayOfAllNodes objectAtIndex:0 withIndex:0];
    if ( btn.nodeType != NodeTypeStart) {
        btn.nodeType = NodeTypeEnd;
        btn.G_ValueCost=0;
        btn.H_ValueCost=0;
        btn.F_ValueCost=0;
        [btn setBackgroundColor:[UIColor blueColor]];
        self.endBtn = btn;
        return;
    }else{
        [self randomStartPoint];
    }
}
-(void)randomBlockWithCount:(NSInteger)count
{
    if (count>=maxY*maxY-2) {
        NSLog(@"大于总方块的数量，错误");
        return;
    }
    for (int i=0; i<count; i++) {
        NSInteger randX = arc4random()%maxX;
        NSInteger randY = arc4random()%maxY;
        UIIndexButton * btn = [self.ArrayOfAllNodes objectAtIndex:randX withIndex:randY];
        if (btn.nodeType != NodeTypeStart && btn.nodeType !=NodeTypeEnd) {
            btn.nodeType = NodeTypeBlock;
            [btn setBackgroundColor:[UIColor blackColor]];
        }
    }
}
-(void)IndexButtonPressed:(UIIndexButton*)btn
{
    NSLog(@"{%d,%d}",btn.PathX,btn.PathY);
    [self nebighourNodeOfNode:btn];
}
-(void)finalPath:(UIIndexButton*)btn
{
    UIIndexButton * abtn = btn;
    while (abtn.parentNode!=nil) {
//        NSLog(@"路径：{%ld,%ld}",abtn.PathX,abtn.PathY);
        if (![abtn checkIsEqualToNode:endBtn]) {
            abtn.backgroundColor = [UIColor purpleColor];
        }
        abtn = abtn.parentNode;
        [abtn setNeedsDisplay];
    }
}


-(void)searchBestPath
{
    [OpenTable insertNode:startBtn];
    while ([OpenTable isEmpty]==NO) {
        UIIndexButton * currenBtn = [OpenTable popBestNodeAndRemove];
//        currenBtn.backgroundColor = [UIColor purpleColor];
//        NSLog(@"%d,%d",currenBtn.PathX,currenBtn.PathY);
        if ([currenBtn checkIsEqualToNode:endBtn]) {
            NSLog(@"寻路结束");
            [self finalPath:currenBtn];
            return;
        }
        
        NSMutableArray * nebourNodeArr = [self nebighourNodeOfNode:currenBtn];
        for (int i=0; i<nebourNodeArr.count; i++) {
            UIIndexButton * abutton = [nebourNodeArr objectAtIndex:i];
            
            BOOL containInOpen = [OpenTable isContainObject:abutton];
            BOOL containInClose =[CloseTable isContainObject:abutton];

            if (containInClose == NO && containInOpen==NO) {

                double HValue =  [abutton caculate_HValue:endBtn];
                double GValue = currenBtn.G_ValueCost+1;
                double FValue = HValue+GValue;
                abutton.H_ValueCost = HValue;
                abutton.G_ValueCost=GValue;
                abutton.F_ValueCost=FValue;
                abutton.parentNode = currenBtn;
                
                [OpenTable insertNode:abutton];
            }else if (containInOpen == YES){
                double HValue =  [abutton caculate_HValue:endBtn];
                double GValue = currenBtn.G_ValueCost+1;
                double FValue = HValue+GValue;
                
                if (FValue<abutton.F_ValueCost) {
                    abutton.H_ValueCost = HValue;
                    abutton.G_ValueCost = GValue;
                    abutton.F_ValueCost = FValue;
                    abutton.parentNode = currenBtn;

                }

                
            }else if (containInClose == YES){
            
                double HValue =  [abutton caculate_HValue:endBtn];
                double GValue = currenBtn.G_ValueCost+1;
                double FValue = HValue+GValue;
                
                if (FValue<abutton.F_ValueCost) {
                    abutton.H_ValueCost = HValue;
                    abutton.G_ValueCost = GValue;
                    abutton.F_ValueCost = FValue;
                    
                    [CloseTable popBestNodeAndRemove];
                    [OpenTable insertNode:abutton];
                    abutton.parentNode = currenBtn;

                }

            }
            [CloseTable insertNode:currenBtn];
            
        }
        
    }
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"!!!!!" message:@"走投无路" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
    [alert show];
}


@end
