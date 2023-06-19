require_relative 'assertions'

module BadPigeon
  class StrictHash < Hash
    include Assertions

    def [](key)
      if has_key?(key)
        super
      else
        assert("Missing hash key: #{key}")
        nil
      end
    end
  end
end
