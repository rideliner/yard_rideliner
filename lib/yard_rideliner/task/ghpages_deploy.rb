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

if ENV['TRAVIS'] && ENV['DOCS']
  namespace :yard do
    if ENV['TRAVIS_PULL_REQUEST'] == 'false'
      require 'ghpages_deploy/rake_task'

      desc 'Deploy documentation to Github Pages'
      GithubPagesGithubPages::DeployTask.new(deploy: [:yard]) do |ghpages|
        ghpages.remote = 'website'
        ghpages.repo = 'https://github.com/rideliner/rideliner.github.io.git'
        ghpages.source = '_yardoc'

        tag = ENV['TRAVIS_TAG']
        branch = ENV['TRAVIS_BRANCH']

        project = PROJECT_NAME || current_gemspec.name
        project_root = "project/#{project}"
        doc_root = "#{project_root}/doc"

        dest_and_msg =
          lambda do |type, loc|
            [
              "#{doc_root}/#{type}/#{loc}",
              "Deploying documentation for #{project}, #{type} #{loc}."
            ]
          end

        abort 'No tag or branch specified' if tag.empty? && branch.empty?

        ghpages.destination, ghpages.message =
          if !tag.empty?
            dest_and_msg['tag', tag]
          elsif !branch.empty?
            dest_and_msg['branch', branch]
          end

        ghpages.json_sitemap(
          directory: doc_root,
          whitelist: ['**/_index.html', '**/index_html'],
          output: "#{project_root}/documentation.json"
        )
      end
    else
      task :deploy do
        puts 'Documentation not generated for pull requests.'
      end
    end
  end
end
