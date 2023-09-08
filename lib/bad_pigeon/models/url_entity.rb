require 'addressable/uri'

module BadPigeon

  #
  # A model that represents a "URL entity" of a tweet (a shortened link with info about the shortened and original URL).
  #

  class URLEntity
    def initialize(json)
      @json = json
    end

    def expanded_url
      Addressable::URI.parse(@json['expanded_url'])
    end
  end
end
