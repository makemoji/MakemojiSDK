//
//  ViewController.m
//  MakemojiSDKDemo
//

#import "ViewController.h"
#import "MakemojiSDK.h"
#import "MEChatTableViewCell.h"
#import "CustomTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.messages = [NSMutableArray array];
    
    self.meTextInputView = [[METextInputView alloc] initWithFrame:CGRectZero];
    self.meTextInputView.delegate = self;
    
    // customization options
    /*
        [self.meTextInputView setKeyboardAppearance:UIKeyboardAppearanceDark];
        [self.meTextInputView setTextInputTextColor:[UIColor whiteColor]];
        self.meTextInputView.placeholderLabel.textColor = [UIColor darkGrayColor];
        self.meTextInputView.textSolidBackgroundView.backgroundColor = [UIColor colorWithRed:0.06 green:0.06 blue:0.08 alpha:1];
        self.meTextInputView.textInputContainerView.backgroundColor = [UIColor colorWithRed:0.07 green:0.07 blue:0.11 alpha:1];
        self.meTextInputView.barBackgroundImageView.backgroundColor = [UIColor colorWithRed:0.07 green:0.07 blue:0.11 alpha:1];
    
        [self.meTextInputView.meAccessory setNavigationBackgroundColor:[UIColor colorWithRed:0.07 green:0.07 blue:0.11 alpha:1]];
        [self.meTextInputView.meAccessory setNavigationHighlightColor:[UIColor colorWithRed:0.10 green:0.10 blue:0.14 alpha:1]];
        self.meTextInputView.meAccessory.backgroundColor = [UIColor colorWithRed:0.07 green:0.07 blue:0.11 alpha:1];
        self.meTextInputView.meAccessory.flashtagCollectionView.backgroundColor = [UIColor colorWithRed:0.07 green:0.07 blue:0.11 alpha:1];
        self.meTextInputView.meAccessory.emojiView.backgroundColor = [UIColor colorWithRed:0.07 green:0.07 blue:0.11 alpha:1];
    
        self.meTextInputView.meAccessory.meInputView.backgroundColor = [UIColor colorWithRed:0.10 green:0.10 blue:0.14 alpha:1];
        self.meTextInputView.meAccessory.meInputView.emojiView.backgroundColor = [UIColor colorWithRed:0.10 green:0.10 blue:0.14 alpha:1];
        self.meTextInputView.meAccessory.meInputView.collectionView.backgroundColor = [UIColor colorWithRed:0.10 green:0.10 blue:0.14 alpha:1];
     */
    
    // possible options
    //self.meTextInputView.displaySendButton = NO;
    //self.meTextInputView.displayCameraButton = NO;
    //self.meTextInputView.keyboardReturnKeyType = UIReturnKeySend;
    //self.meTextInputView.meAccessory.flashtagOnly = YES;

    // disable navigation animation
    //self.meTextInputView.meAccessory.disableNavigation = YES;
    
    // trigger the send callback when a gif is selected
    //self.meTextInputView.shouldAutosendGif = YES;
    
    [self.view addSubview:self.meTextInputView];
    
    // optional detached textInput view
    // to use your own positioning, add the textInputContainerView to your view
    //[self.meTextInputView setFontSize:16.0f];
    //[self.meTextInputView detachTextInputView:YES];
    //[self.view addSubview:self.meTextInputView.textInputContainerView];
    //[self.meTextInputView.textInputContainerView setFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

-(void)openEmojiWall:(id)sender {
    MEEmojiWall * emojiWall = [[MEEmojiWall alloc] init];
    emojiWall.shouldDisplaySearch = YES;
    emojiWall.delegate = self;
    emojiWall.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:emojiWall];
    [navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self presentViewController:navigationController animated:YES completion:nil];
}


-(void)meEmojiWall:(MEEmojiWall *)emojiWall didSelectEmoji:(NSDictionary*)emoji {
    [emojiWall dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@", emoji);
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.meTextInputView showKeyboard];
    
    // test emoji wall
    //[self openEmojiWall:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.meTextInputView.frame.size.height);
}

// handle tapping on linked emoji
-(void)meTextInputView:(METextInputView *)inputView didTapHypermoji:(NSString*)urlString {
       NSLog(@"%@", urlString); 
}

// handle tapping on linked text
-(void)meTextInputView:(METextInputView *)inputView didTapHyperlink:(NSString*)urlString {
    NSLog(@"%@", urlString);
}

// the chat input frame changed size (keyboard show, expanding input)
-(void)meTextInputView:(METextInputView *)inputView didChangeFrame:(CGRect)frame {
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.meTextInputView.frame.origin.y);
    [self scrollToBottom];
    
    if (self.meTextInputView.detachedTextInput == YES) {
        [self.meTextInputView.textInputContainerView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.meTextInputView.frame.origin.y)];
    }
}

// send button was pressed
-(void)meTextInputView:(METextInputView *)inputView didTapSend:(NSDictionary *)message {
    NSLog(@"%@", message);
    [self.messages addObject:message];
    [self.tableView reloadData];
}

// handle camera action
-(void)meTextInputView:(METextInputView *)inputView didTapCameraButton:(UIButton*)cameraButton {
    NSLog(@"didTapCameraButton");
}

// determine row height with HTML
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.meTextInputView == nil) {
        return 0;
    }
    //custom cell
    
    CGSize profileImage = CGSizeMake(50, 50);
    CGFloat horizontalPadding = 5;
    
    NSDictionary * message = [self.messages objectAtIndex:indexPath.row];
    CGFloat messageHeight =  [self.meTextInputView cellHeightForHTML:[message objectForKey:@"html"]
                                                         atIndexPath:indexPath
                                                        maxCellWidth:self.tableView.frame.size.width-profileImage.width-(horizontalPadding*5)
                                                           cellStyle:MECellStyleSimple];
    if (messageHeight < profileImage.height) {
        return profileImage.height;
    }
    return messageHeight;
    /*
    
    
    NSDictionary * message = [self.messages objectAtIndex:indexPath.row];
    return [self.meTextInputView cellHeightForHTML:[message objectForKey:@"html"]
                                       atIndexPath:indexPath
                                      maxCellWidth:self.tableView.frame.size.width
                                         cellStyle:MECellStyleChat];
     */
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    // Chat table cell
//    
//    MEChatTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    if (cell == nil) {
//        cell = [[MEChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    // display chat cell on right side
//    [cell setCellDisplay:MECellDisplayRight];
//    
//    // display chat cell on left side
//    if (indexPath.row % 2) {
//        [cell setCellDisplay:MECellDisplayLeft];
//    }
    
    
    // Custom Cell
    
    CustomTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    

    
    NSDictionary * message = [self.messages objectAtIndex:indexPath.row];
    [cell setHTMLString:[message objectForKey:@"html"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)scrollToBottom {
    if ([self tableView:self.tableView numberOfRowsInSection:0] > 0) {
        [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height)];
    }
}

@end