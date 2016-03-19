//
//  MECollectionViewCell.h
//  MakemojiSDK
//
//  Created by steve on 2/27/16.
//  Copyright © 2016 Makemoji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MEMessageView.h"

@interface MECollectionViewCell : UICollectionViewCell
@property MEMessageView * messageView;

// set HTML for the cell
- (void)setHTMLString:(NSString *)html;

-(CGFloat)cellMaxWidth:(CGFloat)width;
-(CGFloat)heightWithInitialSize:(CGSize)size;

// estimate the width of a cell with HTML constrained to width.
- (CGSize)suggestedFrameSizeToFitEntireStringConstraintedToWidth:(CGFloat)width;

@end
