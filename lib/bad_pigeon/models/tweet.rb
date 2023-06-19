require 'bad_pigeon/models/url_entity'
require 'bad_pigeon/models/user'
require 'bad_pigeon/util/assertions'
require 'bad_pigeon/util/strict_hash'

require 'time'

module BadPigeon
  class Tweet
    include Assertions

    attr_reader :json

    def initialize(json)
      case json['__typename']
      when 'Tweet'
        @json = json
      when 'TweetWithVisibilityResults'
        @json = json['tweet']
      else
        assert("Unexpected tweet record type: #{json['__typename']}")
        @json = json['tweet']
      end
    end

    def legacy
      json['legacy']
    end

    def id
      legacy['id_str'].to_i
    end

    def user
      User.new(json['core']['user_results']['result'])
    end

    def created_at
      Time.parse(legacy['created_at'])
    end

    def text
      legacy['full_text']
    end

    def retweet?
      !!legacy['retweeted_status_result']
    end

    alias retweeted_status? retweet?

    def retweeted_status
      legacy['retweeted_status_result'] && Tweet.new(legacy['retweeted_status_result']['result'])
    end

    def quoted_status?
      # there is also legacy['is_quote_status'], but it may be true while quoted_status_result
      # is not set if the quoted status was deleted
      !!json['quoted_status_result']
    end

    def quoted_status
      json['quoted_status_result'] && Tweet.new(json['quoted_status_result']['result'])
    end

    alias quoted_tweet? quoted_status?
    alias quoted_tweet quoted_status

    def urls
      legacy['entities']['urls'].map { |u| URLEntity.new(u) }
    end

    def attrs
      StrictHash[
        created_at: legacy['created_at'],
        id: id,
        id_str: legacy['id_str'],
        full_text: text,
        entities: legacy['entities'],
      ]
    end
  end
end
