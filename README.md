Makemoji SDK
====================

![](http://i.imgur.com/vrpx4TM.png)

**Makemoji** is a free emoji keyboard for mobile apps. 

By installing our keyboard SDK every user of your app will instantly have access to new and trending emojis. Our goal is to increase user engagement as well as provide actionable real time data on sentiment (how users feel) and affinity (what users like). With this extensive data collection your per-user & company valuation will increase along with your user-base. 
**Features Include**
* Extensive library of free emoji
* 722 standard Unicode emoji
* Makemoji *Flashtag* inline search system

![](http://i.imgur.com/KjrJ8pW.gif)

* New emoji load dynamically and does not require a app update
* Analytics Dashboard & CMS

To obtain your SDK key please email: sdk@makemoji.com

**[Learn More](http://makemoji.com/sdk)**


Library Setup
---------------------

* If you are using CocoaPods for dependencies, include the following.

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


**Setup a the Makemoji TextInput**

Next you will need setup a view controller and add the METextInputView as a property. You will also need to make this conform to the METextInputViewDelegate protocol.

```objectivec

	#import <UIKit/UIKit.h>
	#import "METextInputView.h"

	@interface ViewController : UIViewController <METextInputViewDelegate>
	
	@property (nonatomic, retain) METextInputView * meTextInputView;
	
	@end

```

In your view controller during viewDidLoad or init, initialize the METextInputView.

```objectivec

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.meTextInputView = [[METextInputView alloc] initWithFrame:CGRectZero];
    self.meTextInputView.delegate = self;
    [self.view addSubview:self.meTextInputView];
        
}

```

**Handling Keyboard & Input Size Changes**

You will need to handle keyboard appearance resizing and text input size changes. The didChangeFrame delegate method is called when these events occur.

```objectivec

-(void)meTextInputView:(METextInputView *)inputView didChangeFrame:(CGRect)frame {
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.meTextInputView.frame.origin.y);

}

```


**Send a Message**

The didTapSend delegate callback gives you a dictionary of plaintext and HTML from the MakemojiSDK text view when the Send button is tapped.

```objectivec

-(void)meTextInputView:(METextInputView *)inputView didTapSend:(NSDictionary *)message {
    NSLog(@"%@", message);
    // send message to your backend here
    [self.messages addObject:message];
    [self.tableView reloadData];
}

```

The *messageDictionary* returns the following

`{"html" : "Your Message with HTML", "plaintext" : "Your message translated to plaintext"}`

You would then send this to your backend to store the message.


**Camera Button**

This is a standard UIButton that can be customized. To handle a action for the camera button use the didTapCameraButton delegate callback.

```objectivec

-(void)meTextInputView:(METextInputView *)inputView didTapCameraButton:(UIButton*)cameraButton {
    // Present image controller
}

```

You can show or hide the built-in camera by calling the displayCameraButton method on METextInputView

```objectivec

   [self.meTextInputView displayCameraButton:NO];

```

**Hypermoji - Emoji with a URL**


To handle the display of a webpage when tapping on a Hypermoji ( a emoji with a URL link), use the didTapHypermoji delegate callback

```objectivec

	// handle tapping of links (Hypermoji)
	-(void)meTextInputView:(METextInputView *)inputView didTapHypermoji:(NSString*)urlString {
	    // open webview here
	}

```


**Displaying Messages**

We have included a optimized UITableViewCells for displaying HTML messages. MEChatTableViewCell mimics iMessage display behavior and includes a simple image attachment feature. MESimpleTableViewCell is provided for extensive customization options.

Use the cellHeightForHTML method to give you the row height for a html message. This method caches cell heights for increased performance.

```objectivec

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


FAQ
---------------------

*	The Makemoji SDK is completely free.*	All emojis are served from AWS S3.*	We do not store your messages. Your app backend will have to process and serve messages created with our SDK.*	We do not send push notifications.
*	Your app's message volume does not affect the performance of our SDK.
*	Messages are composed of simple HTML containing image and paragraph tags. Formatting is presented as inline CSS.

