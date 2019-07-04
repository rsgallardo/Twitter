//
//  ComposeViewController.h
//  twitter
//
//  Created by rgallardo on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN


// Protocol so other view controllers can present the ComposeViewController
@protocol ComposeViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;

@end

// Public interface for ComposeViewController
@interface ComposeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *composeText;
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

- (IBAction)closeComposeView:(id)sender;
- (IBAction)tweet:(id)sender;

@end

NS_ASSUME_NONNULL_END


