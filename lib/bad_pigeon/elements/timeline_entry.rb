require 'bad_pigeon/elements/timeline_tweet'
require 'bad_pigeon/util/assertions'

module BadPigeon
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

    def items
      case self.type
      when Type::ITEM
        item_from_content(@json['itemContent'])
      when Type::MODULE
        @json['items'].map { |i| item_from_content(i['item']['itemContent']) }
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
        [TimelineTweet.new(item_content)]
      when 'TimelineUser'
        []
      else
        assert("Unknown itemContent type: #{item_content['itemType']}")
        []
      end
    end
  end
end
