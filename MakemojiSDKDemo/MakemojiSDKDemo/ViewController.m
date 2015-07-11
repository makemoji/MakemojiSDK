//
//  ViewController.m
//  MakemojiSDKDemo
//

#import "ViewController.h"
#import "MakemojiSDK.h"
#import "MEChatTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.messages = [NSMutableArray array];
}

// send button was pressed
-(void)didTapSend:(NSDictionary *)messageDictionary {
    NSLog(@"Your Message - %@", messageDictionary);
    [self.messages addObject:messageDictionary];
    [self.tableView reloadData];
    
    // scroll the table view to the bottom
    [self scrollToBottom];
}

// handle camera action
-(void)didTapCamera {

}

// handle tapping of links (Hypermoji)
-(void)didTapHypermoji:(NSString*)urlString {
    NSLog(@"%@", urlString);
}

// show / hide Camera Button
-(BOOL)hasCameraButton {
    return YES;
}

// determine row height with HTML
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * message = [self.messages objectAtIndex:indexPath.row];
    return [self rowHeightForHTML:[message objectForKey:@"html"] atIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
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
    
    NSDictionary * message = [self.messages objectAtIndex:indexPath.row];
    [cell setHTMLString:[message objectForKey:@"html"]];
    
    return cell;
}

@end