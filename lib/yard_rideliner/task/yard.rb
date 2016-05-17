# encoding: utf-8
# Copyright (c) 2016 Nathan Currier

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'yard'
require 'yard/rake/yardoc_task'

require 'rake/clean'

YARD::Rake::YardocTask.new(:yard) do |t|
  t.files = ['lib/**/*.rb', '-', 'doc/*.md']
  t.files << 'LICENSE.md' if File.exist?('LICENSE.md')

  t.options =
    %w(
      --charset utf-8 --output-dir _yardoc
      --markup markdown --markup-provider kramdown
      --protected --private --hide-void-return
      --plugin yard_rideliner
    )
  t.options += %w(--readme README.md) if File.exist?('README.md')
end

CLEAN.include '.yardoc'
CLOBBER.include '_yardoc'
