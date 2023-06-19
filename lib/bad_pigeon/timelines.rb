Dir[File.join(__dir__, 'timelines', '*.rb')].each { |f| require(f) }

module BadPigeon
  TIMELINE_TYPES = {
    'UserTweets' => UserTimeline,
    'HomeLatestTimeline' => HomeTimeline,
    'HomeTimeline' => HomeTimeline,
    'ListLatestTweetsTimeline' => ListTimeline
  }
end
