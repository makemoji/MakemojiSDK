//
//  MEEmojiWallNativeCollectionViewCell.h
//  MakemojiSDK
//
//  Created by steve on 1/26/16.
//  Copyright © 2016 Makemoji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEEmojiWallNativeCollectionViewCell : UICollectionViewCell
@property UILabel * emojiView;
-(void)setData:(NSDictionary *)data;
@end
