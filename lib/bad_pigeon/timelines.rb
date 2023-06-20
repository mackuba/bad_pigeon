Dir[File.join(__dir__, 'timelines', '*.rb')].each { |f| require(f) }

module BadPigeon
  TIMELINE_TYPES = {
    'UserTweets' => UserTimeline,
    'UserMedia' => UserTimeline,
    'HomeLatestTimeline' => HomeTimeline,
    'HomeTimeline' => HomeTimeline,
    'ListLatestTweetsTimeline' => ListTimeline,

    # ignored requests:
    'AudioSpaceById' => nil,
    'CommunitiesTabBarItemQuery' => nil,
    'DataSaverMode' => nil,
    'GetUserClaims' => nil,
    'ListByRestId' => nil,
    'ListMembers' => nil,
    'ListPins' => nil,
    'ListSubscribers' => nil,
    'ListsManagementPageTimeline' => nil,
    'ProfileSpotlightsQuery' => nil,
    'UserByRestId' => nil,
    'UserByScreenName' => nil,
    'Viewer' => nil,
    'getAltTextPromptPreference' => nil,
  }
end
