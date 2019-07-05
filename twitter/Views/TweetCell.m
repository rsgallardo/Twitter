//
//  TweetCell.m
//  twitter
//
//  Created by rgallardo on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "TimelineViewController.h"
#import "Tweet.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted) {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [self refreshRetweetAndFavorite];
        [self sendUnretweetRequest];
    } else {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        [self refreshRetweetAndFavorite];
        [self sendRetweetRequest];
    }
}

- (void)sendRetweetRequest {
    NSLog(@"self.tweet: %@", self.tweet);
    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
        }
    }];
}

- (void)sendUnretweetRequest {
    [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
        }
    }];
}

- (IBAction)didTapFavorite:(id)sender {
    if (self.tweet.favorited) {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [self refreshRetweetAndFavorite];
        [self sendUnfavoriteRequest];
    } else {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [self refreshRetweetAndFavorite];
        [self sendFavoriteRequest];
    }
}

- (void)sendFavoriteRequest {
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
}

- (void)sendUnfavoriteRequest {
    [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
        }
    }];
}

- (void)refreshRetweetAndFavorite {
    //refresh the titles to display current values
    [self.favoriteButton setTitle:[NSString stringWithFormat:@"%d", self.tweet.favoriteCount] forState:UIControlStateNormal];
    [self.retweetButton setTitle:[NSString stringWithFormat:@"%d", self.tweet.retweetCount] forState:UIControlStateNormal];
    NSLog(@"retweet count: %d", self.tweet.retweetCount);
    //refresh image to reflect current state
    if (self.tweet.favorited) {
        [self.favoriteButton setSelected:YES];
    } else {
        [self.favoriteButton setSelected:NO];
    }
    if (self.tweet.retweeted) {
        [self.retweetButton setSelected:YES];
    } else {
        [self.retweetButton setSelected:NO];
    }
}

@end
