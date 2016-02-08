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
    @property (assign) id delegate;
    @property UILabel * titleLabel;
    @property NSIndexPath * selectedCategory;
    @property UICollectionView * collectionView;
    @property UICollectionView * emojiView;
    @property UICollectionView * gifCategoryView;

    -(void)goBack;
    -(void)selectSection:(NSString *)section;
@end
