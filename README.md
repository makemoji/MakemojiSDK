Makemoji SDK
====================

![](http://i.imgur.com/DqCktsY.png)

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

		pod "Makemoji-SDK"

* If your are not using CocoaPods, be sure to include the following libraries.
		
	* [AFNetworking](https://github.com/AFNetworking/) 2.6.3
	* [SDWebImage](https://github.com/rs/SDWebImage) 3.7.3

* Drag the MakemojiSDK folder to your project.

* In Xcode, click on your App Target -> Build Phases -> Link Binary with Libraries and add the following libraries.

![](http://i.imgur.com/N7HL7Iu.png)

		libsqlite3
		libxml2
		libz

* With iOS 9, you will need to include a exception for AWS S3 in your Info.plist for App Transport.

```
<dict>
	<key>NSAllowsArbitraryLoads</key>
	<true/>
	<key>s3.amazonaws.com</key>
	<dict>
		<key>NSExceptionAllowsInsecureHTTPLoads</key>
		<true/>
	</dict>
</dict>
```

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

In your view controller during viewDidLoad or init, initialize the METextInputView. Use the showKeyboard method to make the text input field the first responder.

```objectivec

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.meTextInputView = [[METextInputView alloc] initWithFrame:CGRectZero];
    self.meTextInputView.delegate = self;
    [self.view addSubview:self.meTextInputView];
        
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.meTextInputView showKeyboard];
}

```

**Detached Text Input**

![](http://i.imgur.com/L6Y4j28.png)

If you need the Text Input detached from the keyboard, you will need to call the detachTextInputView method and then add textInputContainerView to your view.

```objectivec
    [self.meTextInputView detachTextInputView:YES];
    [self.view addSubview:self.meTextInputView.textInputContainerView];

```

Since the Send Button and Camera button are hidden in this mode, you will need to call attach a button to the sendMessage method to trigger capturing the text.

See the included MakemojiSDKDemo app for a full example of how to set this up.

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

You can show or hide the built-in send button by setting the displaySendButton property on METextInputView

```objectivec
   self.meTextInputView.displaySendButton = NO;
```

**Camera Button**

This is a standard UIButton that can be customized. To handle a action for the camera button use the didTapCameraButton delegate callback.

```objectivec

-(void)meTextInputView:(METextInputView *)inputView didTapCameraButton:(UIButton*)cameraButton {
    // Present image controller
}

```

You can show or hide the built-in camera by setting the displayCameraButton property on METextInputView

```objectivec
   self.meTextInputView.displayCameraButton = NO;
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


**Emoji Wall**

The Emoji Wall is a View Controller that allows your users to select one emoji from the makemoji library or the built-in iOS emoji.

![](http://i.imgur.com/oEJMa5F.png)

To display the emoji wall, use the following:

```objectivec
	// initialize the emoji wall view controller
    MEEmojiWall * emojiWall = [[MEEmojiWall alloc] init];
    emojiWall.delegate = self;
    emojiWall.modalPresentationStyle = UIModalPresentationOverCurrentContext;

	// wrap view controller in navigation controller
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:emojiWall];

    [navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [navigationController.navigationBar setTintColor:[UIColor whiteColor]];

	// present the emoji wall as a modal
    [self presentViewController:navigationController animated:YES completion:nil];

```

The search bar can be disabled by using the following when instantiating the controller

```objectivec
    emojiWall.shouldDisplaySearch = NO;
```

When a user selects an emoji from the wall, the following NSDictionary is returned to the Emoji Wall delegate.

For Makemoji emoji:

`
{
    "emoji_id" = 935;
    "emoji_type" = makemoji;
    "image_object" = "<UIImage: 0x7fdaa3f2e0a0>, {110, 110}";
    "image_url" = "http://d1tvcfe0bfyi6u.cloudfront.net/emoji/935-large@2x.png";
    name = Amused;
}
`

For iOS emoji:

`
{
    "emoji_id" = 18;
    "emoji_type" = native;
    name = "pensive face";
    "unicode_character" = "\Ud83d\Ude14";
}
`


Reactions
---------------------
![](http://i.imgur.com/MCQttIW.png)

Makemoji reactions allow you to add inline emoji reactions to any view. Here's how you set this up.

You will first want to init the reaction view and give it a frame, typically a height of 30 is the best, but you can use anyting from 25 to 40.

```
    self.reactionView = [[MEReactionView alloc] initWithFrame:CGRectMake(0, 0, your_width, 30)];
```

You will then want to provide the reaction view with a content id, which is a NSString. THis should be unique to the content you want to associate these reactions to.

```
	self.reactionView.contentId = @"article123";
```
Setting this contentId will retrieve available reaction data as well as retrieve your default reaction set.

If you want to listen for user reacting to this view, observe the MEReactionNotification key.

The notification will include the reaction data that was selected.




FAQ
---------------------

*	The Makemoji SDK is completely free.

*	All emojis are served from AWS S3.

*	We do not store your messages. Your app backend will have to process and serve messages created with our SDK.

*	We do not send push notifications.

*	Your app's message volume does not affect the performance of our SDK.

*	Messages are composed of simple HTML containing image and paragraph tags. Formatting is presented as inline CSS.

*	Will work with any built-in iOS keyboard or return type

*  All network operations happen asyncronously and do not block the User Interface

Service Performance
---------------------

* Avg Service Repsonse Time: 100ms
 
* Hosted with AWS using Elastic Beanstalk & RDS

* Scales seamlessly to meet traffic demands
