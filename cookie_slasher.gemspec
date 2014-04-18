Gem::Specification.new do |spec|
  spec.name = "cookie_slasher"
  spec.version = "0.0.1"

  spec.licenses = ["MIT"]
  spec.authors = ["Olek Poplavsky"]
  spec.email = "olek@woodenbits.com"

  spec.summary = "Rack middleware, removes cookies from responses that are likely to be accidentally cached."
  spec.description = "Use this gem as an extra layer of protection if your system has any HTTP accelerators in front of it, like varnish."
  spec.homepage = "http://github.com/olek/cookie_slasher"

  spec.require_paths = ["lib"]

  require 'rake'
  spec.files = FileList['lib/**/*.rb', '[A-Z]*', 'spec/**/*'].to_a

  spec.test_files = spec.files.grep(%r{^spec/})

  spec.required_ruby_version = ">= 1.9.3"
  spec.required_rubygems_version = ">= 1.3.6"

  # spec.add_development_dependency(%q<rspec>, ["~> 2.13"])
  # spec.add_development_dependency(%q<bundler>, ["~> 1.1"])
end
