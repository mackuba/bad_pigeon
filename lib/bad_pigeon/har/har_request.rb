require 'json'

module BadPigeon
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

    def status
      @json['response']['status']
    end

    def mime_type
      @json['response']['content']['mimeType']
    end

    def has_json_response?
      mime_type == 'application/json'
    end

    def response_body
      @json['response']['content']['text']
    end

    def response_json
      response_body && JSON.parse(response_body)
    end
  end
end
