require 'bad_pigeon/elements/timeline_tweet'
require 'bad_pigeon/util/assertions'

module BadPigeon

  # Represents an "entry" which is a part of a timeline response. An entry in most cases is a wrapper for either one
  # tweet or a group of connected tweets (e.g. a parent and a reply).
  #
  # Tweets can be extracted from an entry using ({#items}) method, which returns an array of tweets as instances of
  # {BadPigeon::TimelineTweet} class.

  class TimelineEntry
    include Assertions

    module Type
      ITEM = "TimelineTimelineItem"
      MODULE = "TimelineTimelineModule"
      CURSOR = "TimelineTimelineCursor"
    end

    attr_reader :json

    def initialize(json)
      @json = json

      assert { json['entryType'] == json['__typename'] }
    end

    def type
      @json['entryType']
    end

    def component
      @json['clientEventInfo'] && @json['clientEventInfo']['component']
    end

    def all_tweets
      items.map(&:tweet).compact
    end

    def items
      case self.type
      when Type::ITEM
        [item_from_content(@json['itemContent'])].compact
      when Type::MODULE
        @json['items'].map { |i| item_from_content(i['item']['itemContent']) }.compact
      when Type::CURSOR
        []
      else
        assert("Unknown entry type: #{type}")
        []
      end
    end

    def item_from_content(item_content)
      case item_content['itemType']
      when 'TimelineTweet'
        TimelineTweet.new(item_content)
      when 'TimelineUser'
        nil
      else
        assert("Unknown itemContent type: #{item_content['itemType']}")
        nil
      end
    end
  end
end
