lib = File.expand_path('../lib', __FILE__)
$:.unshift(lib) unless $:.include?(lib)

require 'rudachi/rb/version'

Gem::Specification.new do |s|
  s.name        = 'rudachi-rb'
  s.version     = Rudachi::RB::VERSION
  s.platform    = Gem::Platform::RUBY
  s.licenses    = 'MIT'
  s.summary     = 'A Ruby wrapper for Sudachi'
  s.email       = '-'
  s.homepage    = 'https://github.com/SongCastle/rudachi-rb'
  s.description = 'A Ruby wrapper for Sudachi.'
  s.author      = 'SongCastle'

  s.files                 = Dir['lib/**/*', 'README.md']
  s.require_paths         = ['lib']
  s.required_ruby_version = Gem::Requirement.new('>= 2.3')

  s.add_runtime_dependency('rjb', '>= 1.1.1')
  s.add_runtime_dependency('rudachi', '>= 1.4.0')
end
