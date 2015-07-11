//
//  ChatViewController.h
//  Makemoji
//
//  Copyright (c) 2015 Makemoji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MEChatTableView.h"
#import "MEInputAccessoryView.h"

@interface MEChatViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

// table view that gets resized
@property MEChatTableView * tableView;

// the navigation / trending keyboard bar
@property MEInputAccessoryView * meAccessory;

// the container for the chat input
@property UIView * meTextView;

// buttons for chat actions
@property UIButton * sendButton;
@property UIButton * cameraButton;

// view controller calls this method when the camera button is tapped
-(void)didTapCamera;

// view controller calls this method when the send button is tapped
// the dictionary contains 'html' and 'plaintext' keys
-(void)didTapSend:(NSDictionary *)messageDictionary;

// method is called when a emoji with a link is tapped.
-(void)didTapHypermoji:(NSString*)urlString;

// this is available for use with MEChatTableViewCell
-(CGFloat)rowHeightForHTML:(NSString *)html atIndexPath:(NSIndexPath *)indexPath;

// show keyboard and resize tableview
-(void)showKeyboard;

// hide keyboard and resize tableview
-(void)hideKeyboard;

// return YES on this method to show the camera button
-(BOOL)hasCameraButton;

// scroll the tableview to the bottom (like iMessage)
-(void)scrollToBottom;

@end
