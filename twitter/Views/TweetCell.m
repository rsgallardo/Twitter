//
//  TweetCell.m
//  twitter
//
//  Created by rgallardo on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

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
    
}

- (IBAction)didTapFavorite:(id)sender {
    if (self.tweet.favorited == NO) {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [self.favoriteButton setSelected:YES];
    } else {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [self.favoriteButton setSelected:NO];
    }
    [self refreshData];
}

- (void)refreshData {
//    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
//        if(error){
//            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
//        }
//        else{
//            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
//        }
//    }];
}


@end
