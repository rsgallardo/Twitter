//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl; //for refreshing tweets once they load
@property (strong, nonatomic) NSMutableArray *tweets;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.tweets = [[NSMutableArray alloc] initWithArray:tweets];
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
//                [self.tableView cellForRowAtIndexPath:];
            }
            [self.tableView reloadData];

            //refresh tweets when dragged down
            //not ending because second line not complete
//            self.refreshControl = [[UIRefreshControl alloc] init];
//            [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
//            [self.tableView insertSubview:self.refreshControl atIndex:0];
            
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
// Automatically adjust table cell height
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    // assign the values for the tweet cell
    Tweet *tweet = self.tweets[indexPath.row]; // set individual tweet based on index
    cell.name.text = tweet.user.name;
    cell.screenName.text = tweet.user.screenName;
    cell.tweetBody.text = tweet.text;
    cell.date.text = tweet.createdAtString;
    cell.retweets.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    cell.favorites.text = [NSString stringWithFormat:@"%d",tweet.favoriteCount];
    
    NSURL *profileImgURL = [NSURL URLWithString:tweet.user.profileImgURL];
    cell.profilePicture.image = nil;
    [cell.profilePicture setImageWithURL:profileImgURL];
    // get image URL
//    NSString *basedURLString = @"https://image.tmdb.org/t/p/w500";
//    NSString *posterURLString = movie[@"poster_path"];
//    NSString *fullPosterURLString = [basedURLString stringByAppendingString:posterURLString];

//    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
//    cell.posterView.image = nil;
//    [cell.posterView setImageWithURL:posterURL];


    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}


@end
