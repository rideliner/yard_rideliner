# encoding: utf-8
# Copyright (c) 2016 Nathan Currier

require './lib/yard_rideliner/version'

Gem::Specification.new do |spec|
  spec.name          = 'yard_rideliner'
  spec.version       = YARD::Dizby::VERSION
  spec.authors       = ['Nathan Currier']
  spec.email         = ['nathan.currier@gmail.com']
  spec.license       = 'MPL-2.0'

  spec.description   = 'YARD plugin for Rideliner\'s projects'
  spec.summary       = 'YARD plugin to template Rideliner\'s projects'
  spec.homepage      = 'https://github.com/rideliner/yard_rideliner'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'kramdown'
  spec.add_dependency 'yard'
  spec.add_dependency 'yardstick'
  spec.add_dependency 'ghpages_deploy'

  spec.add_dependency 'rideliner'
end
