//
//  TweetCell.h
//  twitter
//
//  Created by rgallardo on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *tweetBody;
@property (weak, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
- (IBAction)didTapRetweet:(id)sender;
- (IBAction)didTapFavorite:(id)sender;
- (void)refreshRetweetAndFavorite;
//- (void)sendUnretweetRequest;
//- (void)sendFavoriteRequest;
//- (void)sendUnfavoriteRequest;

@end

NS_ASSUME_NONNULL_END
