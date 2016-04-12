//
//  MakemojiSDK.h
//  MakemojiSDK
//
//  Copyright (c) 2015 Makemoji. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *const MECategoryUnlockedSuccessNotification = @"MECategoryUnlockedSuccessNotification";
static NSString *const MECategoryUnlockedFailedNotification = @"MECategoryUnlockedFailedNotification";

@interface MakemojiSDK : NSObject

+(void)setSDKKey:(NSString *)sdkKey;
+(void)unlockCategory:(NSString *)category;
+(NSArray *)unlockedGroups;
@end
