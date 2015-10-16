//
//  ViewController.m
//  MakemojiSDKDemo
//

#import "ViewController.h"
#import "MakemojiSDK.h"
#import "MEChatTableViewCell.h"
#import "MESimpleTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.messages = [NSMutableArray array];
    
    self.meTextInputView = [[METextInputView alloc] initWithFrame:CGRectZero];
    self.meTextInputView.delegate = self;

    [self.view addSubview:self.meTextInputView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.meTextInputView showKeyboard];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.meTextInputView.frame.size.height);
}

// handle tapping on linked emoji
-(void)meTextInputView:(METextInputView *)inputView didTapHypermoji:(NSString*)urlString {
    NSLog(@"%@", urlString);
}

// the chat input frame changed size (keyboard show, expanding input)
-(void)meTextInputView:(METextInputView *)inputView didChangeFrame:(CGRect)frame {
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.meTextInputView.frame.origin.y);
    
    [self scrollToBottom];
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
    
    NSDictionary * message = [self.messages objectAtIndex:indexPath.row];
    return [self.meTextInputView cellHeightForHTML:[message objectForKey:@"html"]
                                       atIndexPath:indexPath
                                      maxCellWidth:self.tableView.frame.size.width
                                         cellStyle:MECellStyleChat];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    // Chat table cell
    
    MEChatTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[MEChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // display chat cell on right side
    [cell setCellDisplay:MECellDisplayRight];
    
    // display chat cell on left side
    if (indexPath.row % 2) {
        [cell setCellDisplay:MECellDisplayLeft];
    }
    
    
    // Simple Cell
    
    /*
     MESimpleTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     
     if (cell == nil) {
     cell = [[MESimpleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
     }
     */
    
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