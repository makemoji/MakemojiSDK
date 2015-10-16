//
//  METextInputView.h
//  MakemojiSDK
//
//  Copyright © 2015 Makemoji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MEInputAccessoryView.h"

typedef enum
{
    MECellStyleDefault = 0,
    MECellStyleSimple, // full width simple table cell
    MECellStyleChat // Messages style table cell
} MECellStyle;

@protocol METextInputViewDelegate;

@interface METextInputView : UIView

// the navigation / trending keyboard bar
@property IBOutlet MEInputAccessoryView * meAccessory;

// buttons for chat actions
@property IBOutlet UIButton * sendButton;
@property IBOutlet UIButton * cameraButton;

@property CGFloat currentKeyboardPosition;

// textView delegate
@property (assign) id <METextInputViewDelegate> delegate;

// return YES on this method to show the camera button
-(void)displayCameraButton:(BOOL)option;

-(void)showKeyboard;
-(void)hideKeyboard;

-(CGFloat)cellHeightForHTML:(NSString *)html atIndexPath:(NSIndexPath *)indexPath maxCellWidth:(CGFloat)width cellStyle:(MECellStyle)cellStyle;

@end

@protocol METextInputViewDelegate <NSObject>
    -(void)meTextInputView:(METextInputView *)inputView didTapSend:(NSDictionary *)message;
    -(void)meTextInputView:(METextInputView *)inputView didTapHypermoji:(NSString*)urlString;
    -(void)meTextInputView:(METextInputView *)inputView didTapCameraButton:(UIButton*)cameraButton;
    -(void)meTextInputView:(METextInputView *)inputView didChangeFrame:(CGRect)frame;
@end