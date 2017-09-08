# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alfabook_cors/version'

Gem::Specification.new do |spec|
  spec.name          = "alfabook_cors"
  spec.version       = AlfabookCors::VERSION
  spec.authors       = ["Marco Bergantin"]
  spec.email         = ["m.bergantin@alfabook.it"]

  spec.summary       = %q{Add cors rules to network}
  spec.description   = %q{Add cors rules to network.}
  spec.homepage      = "http://www.alfabook.it"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'figaro', '~> 1.1.1'
  spec.add_dependency 'rack-cors', '~> 0.4.0'
end
