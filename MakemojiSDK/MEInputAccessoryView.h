//
//  MEInputAccessoryView.h
//  Makemoji
//
//  Copyright (c) 2015 Makemoji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MEInputView.h"

@interface MEInputAccessoryView : UIView

// navigation buttons
@property UIButton * flashtagButton;
@property UIButton * gridButton;
@property UIButton * trendingButton;
@property UIButton * favoriteButton;

// back button and title shown during category selection
@property UIButton * backButton;
@property UILabel * titleLabel;

// input view for Makemoji emoji
@property MEInputView * meInputView;

// the currently selected mode for the input view
@property NSString * currentToggle;

// flashtag horizontal collection view
@property UICollectionView * flashtagCollectionView;

-(void)didSelectEmoji:(NSDictionary *)emoji image:(UIImage *)image;
-(void)didSelectCategory;
-(void)deleteButtonTapped;
-(void)resetFlashtags;
-(void)setTextView:(id)textView;
-(void)textViewDidBeginEditing:(id)textView;
-(void)textViewDidEndEditing:(id)textView;
-(void)textViewDidChangeSelection:(id)textView;
-(void)textViewDidChange:(id)textView;

@end
