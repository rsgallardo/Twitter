//
//  DetailsViewController.m
//  twitter
//
//  Created by rgallardo on 7/5/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"
#import "TweetCell.h"


@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name.text = self.tweet.user.name;
    self.screenName.text = self.tweet.user.screenName;
    self.date.text = self.tweet.createdAtString;
    self.tweetBody.text = self.tweet.text;
    [self refreshRetweetAndFavorite];
    NSURL *profileImgURL = [NSURL URLWithString:self.tweet.user.profileImgURL];
    self.profileImg.image = nil;
    [self.profileImg setImageWithURL:profileImgURL];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
