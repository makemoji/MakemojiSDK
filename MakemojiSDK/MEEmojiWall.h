//
//  MEEmojiWall.h
//  MakemojiSDK
//
//  Created by steve on 1/22/16.
//  Copyright © 2016 Makemoji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MEEmojiWallDelegate;

@interface MEEmojiWall : UIViewController

@property UICollectionView * emojiCollectionView;
@property UICollectionView * navigationCollectionView;
@property NSIndexPath * selectedCategoryIndex;
@property NSMutableArray * recentEmoji;
@property NSMutableArray * categories;
@property NSMutableArray * categoryEmoji;
@property NSMutableArray * trendingEmoji;
@property NSMutableArray *searchResults;
@property NSString * selectedCategory;
@property NSString * currentKeyword;
@property NSMutableArray * flashTags;

// defaults to YES
@property BOOL shouldDisplaySearch;

// emoji wall delegate
@property (assign) id <MEEmojiWallDelegate> delegate;

@end

@protocol MEEmojiWallDelegate <NSObject>
    -(void)meEmojiWall:(MEEmojiWall *)emojiWall didSelectEmoji:(NSDictionary*)emoji;
@end
