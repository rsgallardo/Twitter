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
#import "ComposeViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView; // table view for displaying tweets on timeline
@property (nonatomic, strong) UIRefreshControl *refreshControl; //for refreshing tweets once they load
@property (strong, nonatomic) NSMutableArray *tweets;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // view controller becomes its dataSource and delegate in viewDidLoad
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Get timeline
    // (4) Make an API request
    [self getHomeTimelineWithCompletionHelper];
    
    //refresh tweets when dragged down
    //not ending because second line not complete
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];

}

// Helper method for getting home timeline to prevent reused code
- (void)getHomeTimelineWithCompletionHelper {
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            // (6) View controller stores data passed into completion handler
            self.tweets = [[NSMutableArray alloc] initWithArray:tweets];
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
            }
            // (7) Reload the table view
            [self.tableView reloadData];

        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
// How is this setting the TimelineViewController as the delegate of the ComposeViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    UINavigationController *navigationController = [segue destinationViewController];
    // Pass the selected object to the new view controller.
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
// Automatically adjust table cell height
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // Use identifier to set cell
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    // assign the values for the tweet cell
    Tweet *tweet = self.tweets[indexPath.row]; // set individual tweet based on index
    cell.name.text = tweet.user.name;
    cell.screenName.text = tweet.user.screenName;
    cell.tweetBody.text = tweet.text;
    cell.date.text = tweet.createdAtString;
    cell.retweets.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    cell.favorites.text = [NSString stringWithFormat:@"%d",tweet.favoriteCount];
    
    // set the profile picture on the tweet
    NSURL *profileImgURL = [NSURL URLWithString:tweet.user.profileImgURL];
    cell.profilePicture.image = nil;
    [cell.profilePicture setImageWithURL:profileImgURL];

    return cell;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    // grab instance of APIManager and get timeline
    [self getHomeTimelineWithCompletionHelper];
    [refreshControl endRefreshing];
}

// Button action to compose a tweet
- (IBAction)compose:(id)sender {
}

// Add tweet to tweets array and then refreshes the data
- (void)didTweet:(Tweet *)tweet {
    [self.tweets addObject:tweet];
    [self getHomeTimelineWithCompletionHelper];
//    [self.tableView reloadData];
}


@end
