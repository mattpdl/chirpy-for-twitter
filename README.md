# Project 3 - *Twitter*

**Chirpy** is a basic twitter app to read and compose tweets with the [Twitter API](https://apps.twitter.com/).

Time spent: **~15** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User sees app icon in home screen and styled launch screen
- [x] User can sign in using OAuth login flow
- [x] User can Logout
- [x] User can view last 20 tweets from their home timeline
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [x] User can pull to refresh.
- [x] User can tap the retweet and favorite buttons in a tweet cell to retweet and/or favorite a tweet.
- [x] User can compose a new tweet by tapping on a compose button.
- [x] Using AutoLayout, the Tweet cell should adjust its layout for iPhone 11, Pro and SE device sizes as well as accommodate device rotation.
- [x] User should display the relative timestamp for each tweet "8m", "7h"
- [x] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet and favorite.

The following **optional** features are implemented:

- [ ] User can view their profile in a *profile tab*
  - Contains the user header view: picture and tagline
  - Contains a section with the users basic stats: # tweets, # following, # followers
  - [ ] Profile view should include that user's timeline
- [x] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count. Refer to [[this guide|unretweeting]] for help on implementing unretweeting.
- [ ] Links in tweets are clickable.
- [ ] User can tap the profile image in any tweet to see another user's profile
  - Contains the user header view: picture and tagline
  - Contains a section with the users basic stats: # tweets, # following, # followers
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [ ] When composing, you should have a countdown for the number of characters remaining for the tweet (out of 280) (**1 point**)
- [x] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [ ] User can reply to any tweet, and replies should be prefixed with the username and the reply_id should be set when posting the tweet (**2 points**)
- [ ] User sees embedded images in tweet if available
- [ ] User can switch between timeline, mentions, or profile view through a tab bar (**3 points**)
- [ ] Profile Page: pulling down the profile page should blur and resize the header image. (**4 points**)


The following **additional** features are implemented:

- [x] Circular profile pictures

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Other types of segues/how to use prepareForSegue method
2. Developing an API manager from scratch

## Video Walkthrough

Here's a walkthrough of implemented user stories:

![Chirpy for Twitter app running in iOS simulator](chirpy-demo.gif)

GIF created with [EZGIF.COM](https://ezgif.com/video-to-gif).

## Notes

Describe any challenges encountered while building the app.

Initially, I could not get the table view to display any tweets after having implemented the core functionality and UI for the timeline view controller.
It turned out I forgot a couple of basic requirements for table view delegates: assigning the view controller as the delegate and data source for the table view, as well as calling reloadData on the table view in my loadTweets method.
Furthermore, while implementing the API calls for the favorite and retweet buttons, the basic functionality worked but the tweet text would not print in the terminal.
Debugging revealed that the Tweet class was only storing the value of "full_text" from each tweet, but the API calls were returning tweet dictionaries with only the value of "text."
I implemented a quick fix so that the Tweet class would fallback on "text" if the value of "full_text" was not returned from an API call.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [BDBOAuth1Manager](https://github.com/bdbergeron/BDBOAuth1Manager) - OAuth library for AFNetworking
- [DateTools](https://github.com/MatthewYork/DateTools) - date and time handling library

## License

    Copyright 2021 Matthew Ponce de Leon

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

# Twitter

### Starter project
The starter project can be found in the `starter-project` tag. Download and run `pod install`.


### Notes
https://paper.dropbox.com/doc/Twitter--ADuVCVvwop_njSNAbUU96Q2VAQ-g255BPX3K4X7G0reYOWCI
