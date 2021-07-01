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
    // Update the local tweet model
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    
    // Update cell UI
    [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    [self.likeButton setTitleColor:[UIColor systemRedColor] forState:UIControlStateNormal];
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

- (void)refreshData {
    // Set tweet labels
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.dateLabel.text = self.tweet.createdAtString;
    self.tweetLabel.text = self.tweet.text;
    
    // Set reply, retweet, and like count labels
    [self.retweetButton setTitle:[NSString stringWithFormat:@"%d", self.tweet.retweetCount] forState:UIControlStateNormal];
    [self.likeButton setTitle:[NSString stringWithFormat:@"%d", self.tweet.favoriteCount] forState:UIControlStateNormal];
    
    // Display profile image
    [self setProfileImg];
}

- (void)setProfileImg {
    // Get profile image URL
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    // Set profile image with URL
    self.profileView.image = nil;
    self.profileView.image = [UIImage imageWithData:urlData];
}

@end
