Makemoji SDK
====================

![](http://i.imgur.com/ctHChYR.png)

**Makemoji** is a free emoji keyboard for mobile apps. 

By installing our keyboard SDK every user of your app will instantly have access to new and trending emojis. Our goal is to increase user engagement as well as provide actionable real time data on sentiment (how users feel) and affinity (what users like). With this extensive data collection your per-user & company valuation will increase along with your user-base. 
**Features Include**
* Extensive library of free emoji
* 722 standard Unicode emoji
* Makemoji *Flashtag* inline search system
* New emoji load dynamically and does not require a app update
* Analytics Dashboard & CMS

To obtain your SDK key please email: sdk@makemoji.com

**[Learn More](http://makemoji.com/sdk)**


Library Setup
---------------------
* If you are already using CocoaPods, add the following pods to your Podfile.

		pod "AFNetworking"
		pod "SDWebImage"

* If your are not using CocoaPods, be sure to include the following libraries.
		
	* [AFNetworking](https://github.com/AFNetworking/)
	* [SDWebImage](https://github.com/rs/SDWebImage)

* Drag the MakemojiSDK folder to your project.

* In Xcode, click on your App Target -> Build Phases -> Link Binary with Libraries and add the following libraries.

![](http://i.imgur.com/N7HL7Iu.png)

		libsqlite3
		libxml2
		libz

SDK Usage
---------------------

**Initialization**

To start using the MakemojiSDK you will first have to add a few lines to your AppDelegate. 

Add the Makemoji header file to you AppDelegate.m file.

```objectivec
#import "MakemojiSDK.h"
```
Then on launch, setup your SDK key.

```objectivec

	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	    // Override point for customization after application launch.

	    // setup your SDK key
	    [MakemojiSDK setSDKKey:@"YOUR-SDK-KEY"];
	    
	    return YES;
	}

```


**Setup a ViewController**

Next you will need setup a view controller to subclass MEChatViewController. This controller has a UITableView (tableView) that you can use for your chat and automatically handles resizing views for showing the keyboard.

```objectivec

	#import <UIKit/UIKit.h>
	#import "MEChatViewController.h"

	@interface ViewController : MEChatViewController

```


**Send a Message**

MEChatViewController also has several callback methods that you will need to override. The didTapSend callback gives you a dictionary of plaintext and HTML from the MakemojiSDK text view when the Send button is tapped.

```objectivec

	-(void)didTapSend:(NSDictionary *)messageDictionary {
	    NSLog(@"Your Message - %@", messageDictionary);
	    [self.messages addObject:messageDictionary];
	    [self.tableView reloadData];
	    
	    // scroll the table view to the bottom
	    [self scrollToBottom];
	}

```

The *messageDictionary* returns the following

`{"html" : "Your Message with HTML", "plaintext" : "Your message translated to plaintext"}`

You would then send this to your backend to store the message.


**Camera Button**

This is a standard UIButton that can be customized. To handle a action for the camera button, override the didTapCamera method

```objectivec

	// handle camera action
	-(void)didTapCamera {
		// handle camera capture
	}

```

You can show or hide the built-in camera button by returning a boolean on the hasCameraButton method

```objectivec

	// show / hide Camera Button
	-(BOOL)hasCameraButton {
	    return YES;
	}

```

**Hypermoji - Emoji with a URL**


To handle the display of a webpage tapping on a Hypermoji ( a emoji with a URL link), override the didTapHypermoji method

```objectivec

	// handle tapping of links (Hypermoji)
	-(void)didTapHypermoji:(NSString*)urlString {
	    NSLog(@"%@", urlString);
	}

```


**Displaying Messages**

We have included a optimized UITableViewCell for displaying HTML messages.

Use the rowHeightForHTML method to give you the row height for a html message.

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

