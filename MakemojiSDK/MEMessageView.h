//
//  MEMessageView.h
//  MakemojiSDK
//
//  Created by steve on 3/7/16.
//  Copyright © 2016 Makemoji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEMessageView : UIView

@property (readonly) UIView * textContentView;
@property (readonly) NSAttributedString * attributedString;

- (void)setHTMLString:(NSString *)html;

// estimate the width of a view with HTML constrained to width.
- (CGSize)suggestedFrameSizeToFitEntireStringConstraintedToWidth:(CGFloat)width;
- (CGSize)suggestedSizeForTextForSize:(CGSize)size;
- (CGSize)intrinsicContentSize;

@end
