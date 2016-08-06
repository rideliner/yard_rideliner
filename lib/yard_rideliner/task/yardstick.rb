# encoding: utf-8
# Copyright (c) 2016 Nathan Currier

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'yardstick/rake/measurement'
require 'yardstick/rake/verify'

Yardstick::Rake::Measurement.new('yard:measure') do |measurement|
  measurement.output = '/dev/stdout'
end

Yardstick::Rake::Verify.new('yard:verify') do |verify|
  verify.threshold = 90
  verify.require_exact_threshold = false
end
