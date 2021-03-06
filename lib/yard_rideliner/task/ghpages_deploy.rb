# encoding: utf-8
# Copyright (c) 2016 Nathan Currier

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

def current_gemspec
  root = `git rev-parse --show-toplevel`.strip
  abort('Only git repositories are supported') unless $?

  gemspecs = Dir["#{root}/*.gemspec"]
  abort "No gemspec found in #{root}" if gemspecs.empty?

  spec = gemspecs.first
  if gemspecs.length > 1
    $stderr.puts "Warning: only using the first gemspec found (#{spec})."
  end

  Gem::Specification.load(spec)
end

REPOSITORY = 'https://github.com/rideliner/rideliner.github.io.git'

namespace :yard do
  if ENV['TRAVIS'] && ENV['DOCS']
    if ENV['TRAVIS_PULL_REQUEST'] == 'false'
      require 'ghpages_deploy/rake_task'

      desc 'Deploy documentation to Github Pages'
      GithubPages::DeployTask.new(deploy: [:yard]) do |ghpages|
        ghpages.remote = 'website'
        ghpages.repo = REPOSITORY
        ghpages.source = '_yardoc'

        project = defined?(PROJECT_NAME) && PROJECT_NAME || current_gemspec.name
        project_root = "project/#{project}"
        doc_root = "#{project_root}/doc"

        tag = ENV['TRAVIS_TAG']
        branch = ENV['TRAVIS_BRANCH']

        abort 'No tag or branch specified' if tag.empty? && branch.empty?

        type, loc = tag.empty? ? ['branch', branch] : ['tag', tag]

        ghpages.destination = "#{doc_root}/#{type}/#{loc}"
        ghpages.message =
          "Deploying documentation for #{project}, #{type} '#{loc}'."

        ghpages.generate_json_sitemap(
          directory: doc_root,
          whitelist: ['**/_index.html', '**/index.html'],
          output: "#{project_root}/documentation.json"
        )
      end
    else
      task :deploy do
        puts 'Documentation not generated for pull requests.'
      end
    end
  else
    task :deploy do
      abort 'Documentation is only deployable from Travis with DOCS env set.'
    end
  end
end
