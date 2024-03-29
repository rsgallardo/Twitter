//
//  Tweet.h
//  twitter
//
//  Created by rgallardo on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tweet : NSObject

// create properties needed for a tweet
@property (nonatomic, strong) NSString *idStr; // For favoriting, retweeting & replying
@property (strong, nonatomic) NSString *text; // Text content of tweet
@property (nonatomic) int favoriteCount; // Update favorite count label
@property (nonatomic) BOOL favorited; // Configure favorite button
@property (nonatomic) int retweetCount; // Update favorite count label
@property (nonatomic) BOOL retweeted; // Configure retweet button
@property (strong, nonatomic) User *user; // Contains name, screenname, etc. of tweet author
@property (strong, nonatomic) NSString *createdAtString; // Display date

// For Retweets
@property (strong, nonatomic) User *retweetedByUser;  // user who retweeted if tweet is retweet
//- (instancetype)initWithDictionary:(NSDictionary *) dictionary; // don't think this is necessary but was here in slide (already defined in User.h
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries; // needs definition here because used in other classes
- (instancetype)initWithDictionary:(NSDictionary *)dictionary; // make public so can use in composeViewController

@end

NS_ASSUME_NONNULL_END
