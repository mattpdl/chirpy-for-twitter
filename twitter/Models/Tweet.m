//
//  Tweet.m
//  twitter
//
//  Created by mattpdl on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DateTools.h"
#import "Tweet.h"
#import "User.h"

@implementation Tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
     self = [super init];
    
     if (self) {
         // Extract original tweet from retweet, if necessary
         NSDictionary *originalTweet = dictionary[@"retweeted_status"];
         if(originalTweet != nil){
             NSDictionary *userDictionary = dictionary[@"user"];
             self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];

             // Change tweet to original tweet
             dictionary = originalTweet;
         }
         
         self.idStr = dictionary[@"id_str"];
         self.text = dictionary[@"full_text"] ? dictionary[@"full_text"] : dictionary[@"text"];
         self.favoriteCount = [dictionary[@"favorite_count"] intValue];
         self.favorited = [dictionary[@"favorited"] boolValue];
         self.retweetCount = [dictionary[@"retweet_count"] intValue];
         self.retweeted = [dictionary[@"retweeted"] boolValue];
         
         // Initialize user
         NSDictionary *user = dictionary[@"user"];
         self.user = [[User alloc] initWithDictionary:user];

         // Parse created_at date string as NSDate
         NSString *createdAtOriginalString = dictionary[@"created_at"];
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
         NSDate *date = [formatter dateFromString:createdAtOriginalString];
         
         // Convert date to string with "short time ago" format
         self.createdAtString = date.shortTimeAgoSinceNow;
     }
    
     return self;
 }

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    // Returns an array of Tweets when passed an array of tweet dictionaries
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}

@end
