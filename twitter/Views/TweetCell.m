//
//  TweetCell.m
//  twitter
//
//  Created by mattpdl on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

- (IBAction)didTapRetweet:(id)sender {
    // Toggle whether tweet has been retweeted
    self.tweet.retweeted = !self.tweet.retweeted;
    
    if (self.tweet.retweeted) {
        [self retweetTweet];
    } else {
        [self unretweetTweet];
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
    
    // Set reply, retweet, and like count labels
    [self.retweetButton setTitle:[NSString stringWithFormat:@"%d", self.tweet.retweetCount] forState:UIControlStateNormal];
    [self.likeButton setTitle:[NSString stringWithFormat:@"%d", self.tweet.favoriteCount] forState:UIControlStateNormal];
    
    // Set whether retweet button has been pressed
    if (self.tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
        [self.retweetButton setTitleColor:[UIColor systemGreenColor] forState:UIControlStateNormal];
    } else {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
        [self.retweetButton setTitleColor:[UIColor labelColor] forState:UIControlStateNormal];
    }
    
    // Set whether like button has been pressed
    if (self.tweet.favorited) {
        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
        [self.likeButton setTitleColor:[UIColor systemRedColor] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
        [self.likeButton setTitleColor:[UIColor labelColor] forState:UIControlStateNormal];
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

@end
