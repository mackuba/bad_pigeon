require_relative 'elements/component'
require_relative 'util/assertions'

module BadPigeon
  class EntryFilter
    include Assertions

    def include_entry?(entry)
      case entry.component
      when Component::ORGANIC_FEED_TWEET,
           Component::ORGANIC_LIST_TWEET,
           Component::NORMAL_TWEET,
           Component::FOLLOWING,
           Component::PINNED_TWEET,
           Component::EXTENDED_REPLY,
           Component::SOCIAL_CONTEXT,
           Component::SOCIAL_ACTIVITY,
           Component::RANKED_FEED_TWEET
           then true

      when Component::PROMOTED_TWEET,
           Component::FOLLOWING_PROMOTED,
           Component::FOLLOW_SUGGESTIONS
           then false

      when nil
        true

      else
        assert("Unknown component: #{entry.component}")
        false
      end
    end
  end
end
