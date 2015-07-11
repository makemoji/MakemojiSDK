//
//  MEInputView.h
//  Makemoji
//
//  Copyright (c) 2015 Makemoji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEInputView : UIView
    @property UIButton * deleteButton;
    @property UIButton * globeButton;
    @property UIPageControl * pageControl;
    @property id delegate;
    @property UILabel * titleLabel;
    @property NSIndexPath * selectedCategory;

    -(void)goBack;
    -(void)selectSection:(NSString *)section;
@end
