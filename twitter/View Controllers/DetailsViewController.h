//
//  DetailsViewController.h
//  twitter
//
//  Created by rgallardo on 7/5/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TweetCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *tweetBody;
@property (weak, nonatomic) Tweet *tweet;
//@property (weak, nonatomic) TweetCell *cell;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

- (IBAction)didTapRetweet:(id)sender;
- (IBAction)didTapFavorite:(id)sender;
- (void)sendRetweetRequest;

@end

NS_ASSUME_NONNULL_END
