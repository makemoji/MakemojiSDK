//
//  ViewController.h
//  MakemojiSDKDemo
//
//  Created by steve on 7/1/15.
//  Copyright (c) 2015 Makemoji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "METextInputView.h"
#import "MEEmojiWall.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, METextInputViewDelegate, MEEmojiWallDelegate>
@property UITableView * tableView;
@property (nonatomic, retain) NSMutableArray * messages;
@property (nonatomic, retain) METextInputView * meTextInputView;
@end

