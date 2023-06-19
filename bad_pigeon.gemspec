# frozen_string_literal: true

require_relative "lib/bad_pigeon/version"

Gem::Specification.new do |spec|
  spec.name = "bad_pigeon"
  spec.version = BadPigeon::VERSION
  spec.authors = ["Kuba Suder"]
  spec.email = ["jakub.suder@gmail.com"]

  spec.summary = "A tool for extracting tweet data from GraphQL fetch requests made by the Twitter website"
  spec.homepage = "https://github.com/mackuba/bad_pigeon"

  spec.description = %(
    BadPigeon is a Ruby gem that allows you to extract tweet data from the XHR requests that the Twitter.com frontend
    website does in user's browser. The requests need to be saved into a "HAR" archive file from the browser's web
    inspector tool and then that file is fed into either the appropriate Ruby class or the `pigeon` command line tool.
    
    The tool intents to be API compatible with the popular `twitter` gem and generate the same kind of tweet JSON
    structure as is read and exported by that library.
  )

  spec.license = "Zlib"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata = {
    "bug_tracker_uri"   => "https://github.com/mackuba/bad_pigeon/issues",
    "changelog_uri"     => "https://github.com/mackuba/bad_pigeon/blob/master/CHANGELOG.md",
    "source_code_uri"   => "https://github.com/mackuba/bad_pigeon",
  }

  spec.files = Dir.chdir(__dir__) do
    Dir['*.md'] + Dir['*.txt'] + Dir['exe/**/*'] + Dir['lib/**/*'] + Dir['sig/**/*']
  end

  spec.require_paths = ["lib"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }

  spec.add_dependency 'addressable', '~> 2.8'
end
