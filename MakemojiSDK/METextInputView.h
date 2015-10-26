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

// container view for the text input view, the send button, camera button and overlay views
@property IBOutlet UIView * textInputContainerView;

// solid background that by default uses the MEMessageEntryBackground image
@property IBOutlet UIImageView * barBackgroundImageView;

// a rounded corner overlay image view that uses the MEMessageEntryInputField image
@property IBOutlet UIImageView * textOverlayImageView;

//background view under text input
@property IBOutlet UIView * textSolidBackgroundView;

// buttons for chat actions
@property IBOutlet UIButton * sendButton;
@property IBOutlet UIButton * cameraButton;

@property IBOutlet UILabel * placeholderLabel;

// the navigation / trending keyboard bar
@property IBOutlet MEInputAccessoryView * meAccessory;


@property CGFloat currentKeyboardPosition;

-(void)setDefaultFontSize:(CGFloat)fontSize;
@property CGFloat fontSize;

// textView delegate
@property (assign) id <METextInputViewDelegate> delegate;

@property BOOL detachedTextInput;

// return YES on this method to show the camera button
-(void)displayCameraButton:(BOOL)option;
-(void)detachTextInputView:(BOOL)option;

-(void)showKeyboard;
-(void)hideKeyboard;

// you can attach a custom button to this method as a action to trigger a send delegate call
-(void)sendMessage;

-(CGFloat)cellHeightForHTML:(NSString *)html atIndexPath:(NSIndexPath *)indexPath maxCellWidth:(CGFloat)width cellStyle:(MECellStyle)cellStyle;

@end

@protocol METextInputViewDelegate <NSObject>
    -(void)meTextInputView:(METextInputView *)inputView didTapSend:(NSDictionary *)message;
    -(void)meTextInputView:(METextInputView *)inputView didTapHypermoji:(NSString*)urlString;
    -(void)meTextInputView:(METextInputView *)inputView didTapCameraButton:(UIButton*)cameraButton;
    -(void)meTextInputView:(METextInputView *)inputView didChangeFrame:(CGRect)frame;
    //@optional
    //-(void)metextInputView:(METextInputView *)inputView textDidChange;
@end