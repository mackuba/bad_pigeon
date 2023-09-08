require_relative 'har_request'
require 'json'

module BadPigeon

  # Represents a whole request archive bundle loaded from a *.har file.
  # 
  # An archive consists of some number of requests ({BadPigeon::HARRequest}).

  class HARArchive
    def initialize(data)
      @json = JSON.parse(data)
    end

    def requests
      @json['log']['entries'].map { |j| HARRequest.new(j) }
    end

    def inspect
      to_s
    end
  end
end
