require 'addressable/uri'
require 'json'

module BadPigeon

  # Represents info about one request and response to it, including the complete response data ({#response_body},
  # or {#response_json} for a parsed JSON form).
  #
  # Requests that may potentially include tweet data return true from the {#includes_tweet_data?} method. The JSON
  # data from each such request represents a "timeline" and may be parsed using a specific timeline class like
  # {BadPigeon::HomeTimeline} or {BadPigeon::UserTimeline}; the {BadPigeon::TIMELINE_TYPES} hash provides a mapping
  # of GraphQL endpoint names to timeline classes, and the endpoint name can be read using {#endpoint_name} method.

  class HARRequest
    def initialize(json)
      @json = json
    end

    def method
      @json['request']['method'].downcase.to_sym
    end

    def url
      @json['request']['url']
    end

    def graphql_endpoint?
      url.start_with?('https://api.twitter.com/graphql/') || url.start_with?('https://twitter.com/i/api/graphql/')
    end

    def includes_tweet_data?
      graphql_endpoint? && status == 200 && has_json_response?
    end

    def endpoint_name
      Addressable::URI.parse(url).path.split('/').last
    end

    def params
      vars = Addressable::URI.parse(url).query_values['variables']
      vars && JSON.parse(vars) || {}
    end

    def status
      @json['response']['status']
    end

    def mime_type
      @json['response']['content']['mimeType']
    end

    def has_json_response?
      mime_type.gsub(/;.*/, '').strip == 'application/json'
    end

    def response_body
      @json['response']['content']['text']
    end

    def response_json
      response_body && JSON.parse(response_body)
    end

    def inspect
      keys = [:method, :url, :status]
      vars = keys.map { |k| "#{k}=#{self.send(k).inspect}" }.join(", ")
      "#<#{self.class}:0x#{object_id} #{vars}>"
    end
  end
end
