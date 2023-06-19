require 'addressable/uri'

module BadPigeon
  class URLEntity
    def initialize(json)
      @json = json
    end

    def expanded_url
      Addressable::URI.parse(@json['expanded_url'])
    end
  end
end
