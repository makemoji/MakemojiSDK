//
//  CustomTableViewCell.m
//  MakemojiSDKDemo
//
//  Created by steve on 3/3/16.
//  Copyright © 2016 Makemoji. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.horizontalPadding = 5;
        self.profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.horizontalPadding, 5, 35, 35)];
        self.profileImage.backgroundColor = [UIColor redColor];
        self.profileImage.layer.cornerRadius = 15;
        [self.contentView addSubview:self.profileImage];
        self.bubbleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        self.bubbleView.backgroundColor = [UIColor colorWithRed:0.898 green:0.898 blue:0.917 alpha:1];
        self.bubbleView.layer.cornerRadius = 8;
        [self.contentView addSubview:self.bubbleView];
        [self.contentView sendSubviewToBack:self.bubbleView];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGSize bubbleMaxSize = CGSizeMake(self.contentView.frame.size.width-self.profileImage.frame.size.width-(self.horizontalPadding*3), self.contentView.frame.size.height-(self.horizontalPadding*2));
    CGSize messageWidth = [self.messageView suggestedSizeForTextForSize:bubbleMaxSize];
    messageWidth.width += (self.horizontalPadding*2);
    if (messageWidth.width < bubbleMaxSize.width) { bubbleMaxSize.width = messageWidth.width; }

    self.bubbleView.frame = CGRectMake(self.profileImage.frame.size.width+(self.horizontalPadding*2), self.horizontalPadding, bubbleMaxSize.width, bubbleMaxSize.height);
    self.messageView.frame = CGRectMake(self.bubbleView.frame.origin.x+self.horizontalPadding, self.bubbleView.frame.origin.y+self.horizontalPadding, self.bubbleView.frame.size.width-(self.horizontalPadding*2), self.bubbleView.frame.size.height-(self.horizontalPadding*2));
}

@end
