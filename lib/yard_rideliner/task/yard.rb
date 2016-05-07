# encoding: utf-8
# Copyright (c) 2016 Nathan Currier

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'yard'
require 'yard/rake/yardoc_task'

require 'rake/clean'

YARD::Rake::YardocTask.new(:yard) do |t|
  t.files = ['lib/**/*.rb', '-', 'doc/*.md', 'LICENSE.md']
  t.options = [
    '--charset utf-8', '--readme README.md',
    '--markup markdown', '--markup-provider kramdown',
    '--output-dir _yardoc',
    '--protected', '--private',
    "--default-return ''",
    '--plugin yard_rideliner'
  ]
end

CLEAN.include '.yardoc'
CLOBBER.include '_yardoc'
