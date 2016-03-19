//
//  MESimpleTableViewCell.h
//  MakemojiSDK
//
//  Created by steve on 10/15/15.
//  Copyright © 2015 Makemoji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MEMessageView.h"

@interface MESimpleTableViewCell : UITableViewCell

@property MEMessageView * messageView;

// set HTML for the cell
- (void)setHTMLString:(NSString *)html;


-(CGFloat)cellMaxWidth:(CGFloat)width;
-(CGFloat)heightWithInitialSize:(CGSize)size;

// estimate the width of a cell with HTML constrained to width.
- (CGSize)suggestedFrameSizeToFitEntireStringConstraintedToWidth:(CGFloat)width;

@end