Dir[File.join(__dir__, 'timelines', '*.rb')].each { |f| require(f) }

module BadPigeon
  TIMELINE_TYPES = {
    'UserTweets' => UserTimeline,
    'UserMedia' => UserTimeline,
    'HomeLatestTimeline' => HomeTimeline,
    'HomeTimeline' => HomeTimeline,
    'ListLatestTweetsTimeline' => ListTimeline,
    'CommunitiesTabBarItemQuery' => nil,
    'DataSaverMode' => nil,
    'GetUserClaims' => nil,
    'ListByRestId' => nil,
    'ListMembers' => nil,
    'ListPins' => nil,
    'ListSubscribers' => nil,
    'ListsManagementPageTimeline' => nil,
    'ProfileSpotlightsQuery' => nil,
    'UserByScreenName' => nil,
    'getAltTextPromptPreference' => nil,
  }
end
