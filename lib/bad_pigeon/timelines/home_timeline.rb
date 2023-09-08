require 'bad_pigeon/elements/timeline_instruction'
require 'bad_pigeon/util/assertions'

module BadPigeon

  # Represents a timeline response for user's "For You" or "Following" timeline.
  #
  # A timeline includes one or more "instructions" ({BadPigeon::TimelineInstruction}), and usually in particular a
  # "TimelineAddEntries" instruction which provides one or more entries containing tweets.

  class HomeTimeline
    include Assertions

    EXPECTED_INSTRUCTIONS = [TimelineInstruction::Type::ADD_ENTRIES]

    def initialize(json)
      @json = json
    end

    def instructions
      @instructions ||= begin
        list = @json['data']['home']['home_timeline_urt']['instructions']
        assert { list.all? { |i| EXPECTED_INSTRUCTIONS.include?(i['type']) }}
        list.map { |j| TimelineInstruction.new(j, self.class) }
      end
    end
  end
end
