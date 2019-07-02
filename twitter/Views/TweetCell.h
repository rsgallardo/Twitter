//
//  TweetCell.h
//  twitter
//
//  Created by rgallardo on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *tweetBody;
@property (weak, nonatomic) IBOutlet UILabel *retweets;
@property (weak, nonatomic) IBOutlet UILabel *favorites;

@property (weak, nonatomic) TweetCell *tweet;

@end

NS_ASSUME_NONNULL_END
