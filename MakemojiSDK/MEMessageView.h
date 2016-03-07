//
//  MEMessageView.h
//  MakemojiSDK
//
//  Created by steve on 3/7/16.
//  Copyright © 2016 Makemoji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEMessageView : UIView
// set HTML for the cell
- (void)setHTMLString:(NSString *)html;

// estimate the width of a cell with HTML constrained to width.
- (CGSize)suggestedFrameSizeToFitEntireStringConstraintedToWidth:(CGFloat)width;

@end
