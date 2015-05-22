//
//  RootViewController.h
//  A_Star
//
//  Created by bliss_ddo on 14-8-18.
//  Copyright (c) 2014年 SELF_PRACTICE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAStarView.h"
@interface RootViewController : UIViewController
{
    UIAStarView * astarView;
}
@property (weak, nonatomic) IBOutlet UIButton *btnConfig;
@end
