require_relative 'har/har_archive'
require_relative 'entry_filter'
require_relative 'util/assertions'
require_relative 'timelines'

require 'uri'

module BadPigeon

  # The main entry point to the library. Pass the contents of a HAR archive file to {#get_tweets_from_har} and get
  # a flat list of all extracted tweets in return.

  class TweetExtractor
    include Assertions

    def initialize
      @filter = EntryFilter.new
    end

    def get_tweets_from_har(har_data)
      archive = HARArchive.new(har_data)
      requests = archive.requests.select(&:includes_tweet_data?)

      timeline_entries = requests.map { |e| timeline_entries_from_request(e) }.flatten
      timeline_entries.select { |e| @filter.include_entry?(e) }.map(&:all_tweets).flatten
    end

    def timeline_entries_from_request(request)
      endpoint = request.endpoint_name

      if timeline_class = TIMELINE_TYPES[endpoint]
        timeline_class.new(request.response_json).instructions.map(&:entries).flatten
      else
        debug "Unknown endpoint: #{endpoint}" unless TIMELINE_TYPES.has_key?(endpoint)
        []
      end
    end
  end
end
