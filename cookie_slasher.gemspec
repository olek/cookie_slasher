# coding: utf-8

Gem::Specification.new do |spec|
  spec.name = 'cookie_slasher'
  spec.version = File.read('lib/cookie_slasher.rb')
                 .match(/^  VERSION = '(.*)'/)[1]

  spec.licenses = ['MIT']
  spec.authors = ['Olek Poplavsky']
  spec.email = 'olek@woodenbits.com'

  spec.summary = 'Rack middleware, removes cookies from responses that ' \
                 'are likely to be accidentally cached.'
  spec.description = 'Use this gem as an extra layer of protection if your ' \
                     'system has any HTTP accelerators in front of it, like ' \
                     'varnish.'
  spec.homepage = 'http://github.com/olek/cookie_slasher'

  spec.require_paths = ['lib']

  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
end
