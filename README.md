Makemoji SDK 1.0

Library Setup

	1a. If you are already using CocoaPods, add the following pods to your Podfile
		pod "AFNetworking"
		pod 'SDWebImage'

	1b. If your are not using CocoaPods, be sure to include the following libraries
		AFNetworking - https://github.com/AFNetworking/AFNetworking
		SDWebImage - https://github.com/rs/SDWebImage

	2. Drag the MakemojiSDK folder to your project.

	3. In Xcode, click on your App Target -> Build Phases -> Link Binary with Libraries and add the following
		libsqlite3
		libxml2
		libz

To start using the MakemojiSDK you will first have to setup your API key in your AppDelegate 

	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	    // Override point for customization after application launch.

	    // setup your SDK key
	    [MakemojiSDK setSDKKey:@"YOUR-SDK-KEY"];
	    
	    return YES;
	}

Next you will need to subclass MEChatViewController. This controller has a tableview that you can use for your chat and automatically handles resizing views for showing the keyboard.

	#import <UIKit/UIKit.h>
	#import "MEChatViewController.h"

	@interface ViewController : MEChatViewController

This view controller also has several callback methods that you will need to override

The didTapSend callback gives you a dictionary of plaintext and HTML from the MakemojiSDK text view when the Send button is tapped.

	-(void)didTapSend:(NSDictionary *)messageDictionary {
	    NSLog(@"Your Message - %@", messageDictionary);
	    [self.messages addObject:messageDictionary];
	    [self.tableView reloadData];
	    
	    // scroll the table view to the bottom
	    [self scrollToBottom];
	}

You can show or hide the built-in camera button by returning a boolean on the hasCameraButton method

	// show / hide Camera Button
	-(BOOL)hasCameraButton {
	    return YES;
	}

To handle a action for the camera button, override the didTapCamera method

	// handle camera action
	-(void)didTapCamera {

	}

To handle the display of a webpage tapping on a Hypermoji ( a emoji with a URL link) override the didTapHypermoji method

	// handle tapping of links (Hypermoji)
	-(void)didTapHypermoji:(NSString*)urlString {
	    NSLog(@"%@", urlString);
	}


We have included a optimized table view cell for displaying HTML messages. To use this table cell, you should use the following:

Using the rowHeightForHTML method gives the row height for a message

	- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	    NSDictionary * message = [self.messages objectAtIndex:indexPath.row];
	    return [self rowHeightForHTML:[message objectForKey:@"html"] atIndexPath:indexPath];
	}

You can set the MEChatTableViewCell to display on the left or right hand side using setCellDisplay. This should happen before setting your HTML for each message.

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


