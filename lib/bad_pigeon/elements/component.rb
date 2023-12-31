module BadPigeon
  module Component
    # normal tweet in e.g. home/latest or a user's timeline
    ORGANIC_FEED_TWEET = "suggest_ranked_organic_tweet"
    NORMAL_TWEET = "tweet"

    # tweet in the latest timeline
    FOLLOWING = "following_in_network"

    # tweet in a list timeline
    ORGANIC_LIST_TWEET = "suggest_organic_list_tweet"

    # user's pinned tweets
    PINNED_TWEET = "suggest_pinned_tweet"
    PINNED_TWEETS = "pinned_tweets"

    # reply that shows up in your timeline
    EXTENDED_REPLY = "suggest_extended_reply"

    # algorithmic timeline suggested tweets
    SOCIAL_CONTEXT = "suggest_sc_tweet"                     # X follows
    SOCIAL_ACTIVITY = "suggest_activity_tweet"              # X liked
    RANKED_FEED_TWEET = "suggest_ranked_timeline_tweet"

    # promoted tweet (ad)
    PROMOTED_TWEET = "suggest_promoted"
    FOLLOWING_PROMOTED = "following_promoted"

    # "Who to follow" block
    FOLLOW_SUGGESTIONS = "suggest_who_to_follow"
  end
end
