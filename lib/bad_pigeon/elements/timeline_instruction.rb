require 'bad_pigeon/elements/timeline_entry'
require 'bad_pigeon/util/assertions'

module BadPigeon

  # Represents an "instruction" which is a part of a timeline response. An instruction can be e.g. pinning one entry
  # to the top or adding some number of entries to the list view.
  #
  # A timeline includes one or more "entries" ({BadPigeon::TimelineEntry}), most of which contain one or more tweets.

  class TimelineInstruction
    include Assertions

    module Type
      ADD_ENTRIES = "TimelineAddEntries"
      CLEAR_CACHE = "TimelineClearCache"
      PIN_ENTRY = "TimelinePinEntry"
    end

    def initialize(json, timeline_class)
      @json = json
      @timeline_class = timeline_class
    end

    def type
      @json['type']
    end

    def entries
      case type
      when Type::ADD_ENTRIES
        expected_keys = ['entries', 'type']
        entries = @json['entries']

        case @timeline_class
        when ListTimeline
          expected_types = [TimelineEntry::Type::ITEM, TimelineEntry::Type::CURSOR]
        else
          expected_types = [TimelineEntry::Type::ITEM, TimelineEntry::Type::MODULE, TimelineEntry::Type::CURSOR]
        end

      when Type::CLEAR_CACHE
        expected_keys = ['type']
        entries = []

      when Type::PIN_ENTRY
        expected_keys = ['entry', 'type']
        entries = [@json['entry']]
        expected_types = [TimelineEntry::Type::ITEM]

      else
        assert("Unknown timeline instruction type: #{type}")
        return []
      end

      assert { @json.keys.sort == expected_keys }
      assert { entries.all? { |e| expected_types.include?(e['content']['entryType']) }}
      assert { entries.all? { |e| e.keys.sort == ['content', 'entryId', 'sortIndex'] }}

      entries.map { |e| TimelineEntry.new(e['content']) }
    end
  end
end
