#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    MECellDisplayDefault = 0,
    MECellDisplayLeft, // display the bubble on the left hand side
    MECellDisplayRight // display the bubble on the right hand side
} MECellDisplay;

@interface MEChatTableViewCell : UITableViewCell

// the iMessage like bubble
@property UIImageView * bubbleView;

// the tail for the bubble
@property UIImageView * caretView;

@property NSString * imageUrl;
@property UIImageView * attachmentView;
@property MECellDisplay cellDisplay;
@property UIView * messageView;

// set HTML for the cell
- (void)setHTMLString:(NSString *)html;

-(CGFloat)cellMaxWidth:(CGFloat)width;
-(CGFloat)heightWithInitialSize:(CGSize)size;

// estimate the width of a cell with HTML constrained to width. includes bubble padding
- (CGSize)suggestedFrameSizeToFitEntireStringConstraintedToWidth:(CGFloat)width;

@end