require 'bad_pigeon/elements/timeline_instruction'
require 'bad_pigeon/util/assertions'

module BadPigeon
  class ListTimeline
    include Assertions

    EXPECTED_INSTRUCTIONS = [TimelineInstruction::Type::ADD_ENTRIES]

    def initialize(json)
      @json = json
    end

    def instructions
      @instructions ||= begin
        list = @json['data']['list']['tweets_timeline']['timeline']['instructions']
        assert { list.all? { |i| EXPECTED_INSTRUCTIONS.include?(i['type']) }}
        list.map { |j| TimelineInstruction.new(j, self.class) }
      end
    end
  end
end
