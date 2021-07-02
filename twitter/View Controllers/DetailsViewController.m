//
//  DetailsViewController.m
//  twitter
//
//  Created by mattpdl on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshData];
}

- (IBAction)didTapRetweet:(id)sender {
    // Toggle whether tweet has been liked
    self.tweet.retweeted = !self.tweet.retweeted;
    
    if (self.tweet.retweeted) {
        [self retweetTweet];
    } else {
        [self unretweetTweet];
    }
}

- (IBAction)didTapFavorite:(id)sender {
    // Toggle whether tweet has been liked
    self.tweet.favorited = !self.tweet.favorited;
    
    if (self.tweet.favorited) {
        [self favoriteTweet];
    } else {
        [self unfavoriteTweet];
    }
    
}

- (void)favoriteTweet {
    // Update the local tweet model and cell UI
    self.tweet.favoriteCount += 1;
    [self refreshData];

    // Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        } else {
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
}

- (void)unfavoriteTweet {
    // Update the local tweet model and cell UI
    self.tweet.favoriteCount -= 1;
    [self refreshData];
    
    // Send a POST request to the POST favorites/destroy endpoint
    [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        } else {
            NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
        }
    }];
}

- (void)retweetTweet {
    // Update the local tweet model and cell UI
    self.tweet.retweetCount += 1;
    [self refreshData];
    
    // Send a POST request to the POST statuses/retweet endpoint
    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        } else {
            NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
        }
    }];
}

- (void)unretweetTweet {
    // Update the local tweet model and cell UI
    self.tweet.retweetCount -= 1;
    [self refreshData];
    
    // Send a POST request to the POST statuses/unretweet endpoint
    [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        } else {
            NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
        }
    }];
}

- (void)refreshData {
    // Set tweet labels
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.dateLabel.text = self.tweet.createdAtString;
    self.tweetLabel.text = self.tweet.text;
    
    // Set retweet and like count labels
    self.retweetLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.likeLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
    // Set whether retweet button has been pressed
    if (self.tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    } else {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
    
    // Set whether like button has been pressed
    if (self.tweet.favorited) {
        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    
    // Display profile image
    [self setProfileImg];
}

- (void)setProfileImg {
    // Get profile image URL (of original size)
    NSString *URLString = [self.tweet.user.profilePicture stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    // Set profile image with URL and make circular
    [self.profileView.layer setCornerRadius:self.profileView.frame.size.height / 2];
    [self.profileView.layer setMasksToBounds:YES];
    self.profileView.image = [UIImage imageWithData:urlData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
