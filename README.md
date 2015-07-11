Makemoji SDK
====================

![](http://i.imgur.com/ctHChYR.png)

**Makemoji** is a free emoji keyboard for mobile apps. A 3rd party app installs our keyboard SDK and every user of that app will instantly have new emojis and more to talk about. Our goal is to increase user engagement as well as provide actionable real time data on sentiment (how users feel) and affinity (what users like). Because apps can now collect sentiment & affinity data in addition to age, gender and location... they will know more about their user base and their per-user valuation & company valuation will increase they second they implement our SDK. We also provide an extensive library of free emojis (in addition to iOS/Android’s 722 standard Unicode emojis) that are updated daily with trending emojis. New emojis are loaded in seamlessly through an Internet connection and do not require the user to update the app.


Library Setup
---------------------
1. If you are already using CocoaPods, add the following pods to your Podfile.

		pod "AFNetworking"
		pod "SDWebImage"

2. If your are not using CocoaPods, be sure to include the following libraries.
		
		AFNetworking - https://github.com/AFNetworking/AFNetworking
		SDWebImage - https://github.com/rs/SDWebImage

3. Drag the MakemojiSDK folder to your project.

3. In Xcode, click on your App Target -> Build Phases -> Link Binary with Libraries and add the following libraries.

![](http://i.imgur.com/N7HL7Iu.png)

		libsqlite3
		libxml2
		libz

SDK Usage
---------------------
To start using the MakemojiSDK you will first have to setup your API key in your AppDelegate 

```objectivec

	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	    // Override point for customization after application launch.

	    // setup your SDK key
	    [MakemojiSDK setSDKKey:@"YOUR-SDK-KEY"];
	    
	    return YES;
	}

```

Next you will need to subclass MEChatViewController. This controller has a tableview that you can use for your chat and automatically handles resizing views for showing the keyboard.

```objectivec

	#import <UIKit/UIKit.h>
	#import "MEChatViewController.h"

	@interface ViewController : MEChatViewController

```

This view controller also has several callback methods that you will need to override

The didTapSend callback gives you a dictionary of plaintext and HTML from the MakemojiSDK text view when the Send button is tapped.

```objectivec

	-(void)didTapSend:(NSDictionary *)messageDictionary {
	    NSLog(@"Your Message - %@", messageDictionary);
	    [self.messages addObject:messageDictionary];
	    [self.tableView reloadData];
	    
	    // scroll the table view to the bottom
	    [self scrollToBottom];
	}

```

You can show or hide the built-in camera button by returning a boolean on the hasCameraButton method

```objectivec

	// show / hide Camera Button
	-(BOOL)hasCameraButton {
	    return YES;
	}

```

To handle a action for the camera button, override the didTapCamera method

```objectivec

	// handle camera action
	-(void)didTapCamera {

	}

```

To handle the display of a webpage tapping on a Hypermoji ( a emoji with a URL link) override the didTapHypermoji method

```objectivec

	// handle tapping of links (Hypermoji)
	-(void)didTapHypermoji:(NSString*)urlString {
	    NSLog(@"%@", urlString);
	}

```

We have included a optimized table view cell for displaying HTML messages. To use this table cell, you should use the following:

Using the rowHeightForHTML method gives the row height for a message

```objectivec

	- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	    NSDictionary * message = [self.messages objectAtIndex:indexPath.row];
	    return [self rowHeightForHTML:[message objectForKey:@"html"] atIndexPath:indexPath];
	}

```

You can set the MEChatTableViewCell to display on the left or right hand side using setCellDisplay. This should happen before setting your HTML for each message.

```objectivec

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

```

