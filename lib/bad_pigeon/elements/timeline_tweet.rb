require 'bad_pigeon/models/tweet'
require 'bad_pigeon/util/assertions'

module BadPigeon
  class TimelineTweet
    include Assertions

    def initialize(json)
      @json = json
    end

    def result_type
      @json['tweet_results']['result'] && @json['tweet_results']['result']['__typename']
    end

    def tweet_data
      case result_type
      when 'Tweet', 'TweetWithVisibilityResults'
        @json['tweet_results']['result']
      when 'TweetUnavailable'
        nil
      when nil
        nil
      else
        assert("Unknown tweet result type: #{result_type}")
        nil
      end
    end

    def tweet
      Tweet.new(tweet_data)
    end
  end
end
