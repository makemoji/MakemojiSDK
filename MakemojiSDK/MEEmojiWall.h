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
@property NSMutableArray * categories;
@property NSMutableDictionary * categoryDictionary;
@property NSMutableArray * trendingEmoji;
@property NSMutableArray *searchResults;
@property NSString * selectedCategory;
@property NSString * currentKeyword;
@property NSMutableArray * flashTags;
@property BOOL shouldDisplayUnicodeEmoji;
@property BOOL shouldDisplayUsedEmoji;
@property BOOL shouldDisplayTrendingEmoji;

// defaults to YES
@property BOOL shouldDisplaySearch;

// defaults to 38
@property CGFloat navigationHeight;

// defaults to grid of 5x7
@property CGSize emojiSize;

// emoji wall delegate
@property (assign) id <MEEmojiWallDelegate> delegate;

-(void)setupLayoutWithSize:(CGSize)size;

@end

@protocol MEEmojiWallDelegate <NSObject>
    -(void)meEmojiWall:(MEEmojiWall *)emojiWall didSelectEmoji:(NSDictionary*)emoji;
@optional
    -(void)meEmojiWall:(MEEmojiWall *)emojiWall didSelectCategory:(NSDictionary *)category;
    -(void)meEmojiWall:(MEEmojiWall *)emojiWall startedLoadingEmoji:(NSArray *)categories;
    -(void)meEmojiWall:(MEEmojiWall *)emojiWall finishedLoadingEmoji:(NSDictionary *)emoji;
    -(void)meEmojiWall:(MEEmojiWall *)emojiWall failedLoadingEmoji:(NSError *)error;
@end
