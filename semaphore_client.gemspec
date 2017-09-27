# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'semaphore_client/version'

Gem::Specification.new do |spec|
  spec.name          = "semaphore_client"
  spec.version       = SemaphoreClient::VERSION
  spec.authors       = ["Jovan Ivanović"]
  spec.email         = ["jivanovic@renderedtext.com"]

  spec.summary       = %q{Client for Semaphore's API.}
  spec.homepage      = "https://github.com/renderedtext/semaphore-client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.13.1"
  spec.add_dependency "faraday_middleware", "~> 0.12.2"

  spec.add_development_dependency "byebug"
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
