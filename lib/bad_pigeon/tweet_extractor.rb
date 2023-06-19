require_relative 'har/har_archive'
require_relative 'entry_filter'
require_relative 'timelines'

require 'uri'

module BadPigeon
  class TweetExtractor
    def initialize
      @filter = EntryFilter.new
    end

    def get_tweets_from_har(har_data)
      archive = HARArchive.new(har_data)

      requests = archive.entries.select { |e|
        e.graphql_endpoint? && e.method == :get && e.status == 200 && e.has_json_response?
      }

      entries = requests.map { |e|
        endpoint = URI(e.url).path.split('/').last

        if timeline_class = TIMELINE_TYPES[endpoint]
          timeline_class.new(e.response_json).instructions.map(&:entries)
        elsif !TIMELINE_TYPES.has_key?(endpoint)
          puts "Unknown endpoint: #{endpoint}"
          []
        end
      }.flatten

      entries.select { |e| @filter.include_entry?(e) }.map(&:items).flatten.map(&:tweet).compact
    end
  end
end
