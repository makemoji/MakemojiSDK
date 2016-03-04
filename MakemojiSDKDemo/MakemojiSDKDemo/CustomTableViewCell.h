//
//  CustomTableViewCell.h
//  MakemojiSDKDemo
//
//  Created by steve on 3/3/16.
//  Copyright © 2016 Makemoji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MESimpleTableViewCell.h"


@interface CustomTableViewCell : MESimpleTableViewCell
    @property UIImageView * profileImage;
    @property UIView * bubbleView;
    @property CGFloat horizontalPadding;
@end
