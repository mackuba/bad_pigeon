require 'bad_pigeon/models/tweet'
require 'bad_pigeon/util/assertions'

module BadPigeon

  # Represents a single tweet in a timeline (may possibly include no data in some cases).
  #
  # Use the {#tweet} method to get an instance of {BadPigeon::Tweet}, which is the final tweet model from which you can
  # extract specific fields or a properly formatted JSON representation.

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
