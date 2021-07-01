//
//  TweetCell.h
//  twitter
//
//  Created by mattpdl on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

// UI properties
@property (weak, nonatomic) IBOutlet UIImageView *profileView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

// Tweet property
@property (strong, nonatomic) Tweet *tweet;

// Methods
- (void)refreshData;

@end

NS_ASSUME_NONNULL_END
