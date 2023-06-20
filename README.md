# BadPigeon

A tool for exporting tweet data from Twitter by parsing GraphQL fetch requests made by the Twitter website.

<p>
  <img src="https://github.com/mackuba/bad_pigeon/assets/28465/99c3eee1-1fab-41be-a909-6b53d141b7db" width="600"><br>
  <i>Photo by Martin Vorel, <a href="https://libreshot.com">libreshot.com</a></i>
</p>


## What is this about?

**Problem:** You were running some kind of project that used Twitter API to load tweets from some number of feeds and process them in some way - for archiving, research, statistics, whatever. Now the free API access has been shut down, all your API keys have been revoked and your project doesn't work anymore ☹️

**Solution 1:** sign up for paid access and pay more than all your streaming, media, internet, mobile and app subscriptions combined every month just to fetch some tweets 🤑💰💰💰

**Solution 2:** go the Chad Scraper route and scrape the data from the website with some scripts, playing a cat and mouse game and worrying that your account and/or IP will be blocked 😬

**Solution 3:** passively record the requests that the Twitter frontend is making to the API using Safari Web Inspector, then use some Ruby code to extract any data you want from the saved JSON responses 🤔


## How it works:

1. Open the Twitter website in a browser (preferably Safari or Firefox).
2. Open the Web Inspector / Developer Tools on the Network tab.
    - in Safari, make sure the "Export" button is not grayed out; if it is, reload the page first
3. Scroll through some timelines (home, lists etc.) to make sure everything you want to save has been loaded.
4. In the Network tab list, type "graphql" to the filter bar - only those requests are parsed, so no point making the archive larger than necessary.
    - it seems that Chrome-based browsers always export all requests to the archive, so the file size gets into tens of megabytes very quickly - so it's better to use Safari or Firefox, which only export requests matching the filter
5. Click "Export" and save the requests to a "HAR" archive file.
    - in Safari, the button is in the top-right corner of the Network tab
    - in Firefox, click the "gear" button in the top-right corner and choose "Save All As HAR"
    - in Chrome, click the down arrow button at the end of the top toolbar
6. Feed the archive file to the Bad Pigeon (the Ruby code or the command line tool).
7. Profit 👍

Note: one obvious drawback of this method is that the request recording part is somewhat manual, so it's (probably) not possible to completely automate it so that it runs on a server somewhere, unattended. However, it should be enough if you're ok with having to remember to periodically browse through a few timelines, save the export and run a script on it.


## Stability warning ⚠️

This is a very early version of this tool. The API \*will\* change between versions, possibly even between point releases. Don't be surprised if something breaks.


## How to use:

To install the tool, run:

```
gem install bad_pigeon
```

The [`TweetExtractor`](https://github.com/mackuba/bad_pigeon/blob/docs/lib/bad_pigeon/tweet_extractor.rb) class is the entry point. Pass the contents of the `.har` file to the `#get_tweets_from_har` method to get an array of `Tweet` objects parsed from the whole archive:

```rb
require 'bad_pigeon'

data = File.read(path_to_har)
extractor = BadPigeon::TweetExtractor.new
tweets = extractor.get_tweets_from_har(data)

tweets.sort_by(&:created_at).reverse.each do |tweet|
  puts "#{tweet.created_at} @#{tweet.user.screen_name}: \"#{tweet.text}\""
end
```

The `Tweet` class is meant to be API compatible with the one from the popular [twitter gem](https://github.com/sferik/twitter/), so you should be able to use it as a drop-in replacement if your project used that library (although only some subset of properties will work right now - please [report issues](https://github.com/mackuba/bad_pigeon/issues) for any missing ones).


### Command line

The gem also installs a command-line script `pigeon`. You can pass it the archive file and get a JSON array of tweet data on the output:

```
pigeon < tweets.har > tweets.json
```

At the moment this is the only thing it does. There will be some options in the future to e.g. filter the tweets only from some sources and so on. The format that it exports the tweets in is also meant to match the hashes returned from the `#attrs` method in the `Tweet` class in the [twitter gem](https://github.com/sferik/twitter/).


## Credits

Copyright © 2023 Kuba Suder ([@mackuba.eu](https://bsky.app/profile/mackuba.eu)).

The code is available under the terms of the [zlib license](https://choosealicense.com/licenses/zlib/) (permissive, similar to MIT).

Bug reports and pull requests are welcome 😎 (note: if you're having problems parsing some tweets, please send me links to some examples of specific tweets that are making it fail).

---

#### Why *bad* pigeon?

Because pigeons are generally bad :<
