module BadPigeon
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
