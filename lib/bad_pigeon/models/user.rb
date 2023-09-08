module BadPigeon

  #
  # A model that represents a user with an interface matching that from the original `twitter` Ruby gem.
  #

  class User
    attr_reader :json

    def initialize(json)
      @json = json
    end

    def legacy
      json['legacy']
    end

    def screen_name
      legacy['screen_name']
    end
  end
end
