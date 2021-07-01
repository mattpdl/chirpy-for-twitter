//
//  ComposeViewController.m
//  twitter
//
//  Created by mattpdl on 6/30/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#define placeholderText @"What's on your mind?"

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *composeTextView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.composeTextView.delegate = self;
    
    [self.composeTextView becomeFirstResponder];
}

- (void)composeTweet {
    NSString *tweetText = self.composeTextView.text;
    
    [[APIManager shared] postStatusWithText:tweetText completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
            // TODO: display error
        } else {
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
            NSLog(@"Compose Tweet Success!");
        }
    }];
}

- (IBAction)didTapClose:(id)sender {
    // Dismiss modal compose view
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)didTapPost:(id)sender {
    [self composeTweet];
}

- (void)textViewDidChange:(UITextView *)textView {
    // Show placeholder text when no text has been entered
    if (self.composeTextView.text.length == 0) {
        [self.placeholderLabel setHidden:false];
    } else {
        [self.placeholderLabel setHidden:true];
    }
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
