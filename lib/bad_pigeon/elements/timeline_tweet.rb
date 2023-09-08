require 'bad_pigeon/models/tweet'
require 'bad_pigeon/util/assertions'

module BadPigeon
  class TimelineTweet
    include Assertions

    def initialize(json)
      @json = json
    end

    def tweet
      @json['tweet_results']['result'] && Tweet.from_result(@json['tweet_results']['result'])
    end
  end
end
