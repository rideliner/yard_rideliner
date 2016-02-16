# encoding: utf-8
# Copyright (c) 2016 Nathan Currier

def javascripts
  super + %w(js/view_on_github.js)
end

def menu_lists
  super + [{ type: 'version', title: 'Versions', search_title: 'Version List' }]
end
