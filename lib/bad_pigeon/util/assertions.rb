module AngryPigeon
  class AssertionError < StandardError; end
end

module BadPigeon
  module Assertions
    def self.included(target)
      if ENV['ANGRY_PIGEON'] == '1'
        target.define_method(:assert) do |msg = nil, &block|
          raise AngryPigeon::AssertionError.new(msg) if msg || block.call == false
        end
        target.define_method(:debug) do |msg|
          $stderr.puts msg
        end
      else
        target.define_method(:assert) do |msg = nil, &block|
        end
        target.define_method(:debug) do |msg|
        end
      end
    end
  end
end
