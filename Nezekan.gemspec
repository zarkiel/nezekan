# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#require "nezekan/version"


Gem::Specification.new do |spec|
  spec.name          = "nezekan"
  spec.version       = "1.0.2" #Nezekan::VERSION
  spec.authors       = ["Zarkiel"]
  spec.email         = ["zarkiel@gmail.com"]

  spec.summary       = %q{A complete collection of security interfaces and sessions.}
  spec.description   = %q{A complete collection of security interfaces.}
  spec.homepage      = "https://github.com/zarkiel/nezekan"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata["allowed_push_host"] = "http://mygemserver.com"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against " \
  #    "public gem pushes."
  #end

  
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.files = ["lib/nezekan.rb"]

end
