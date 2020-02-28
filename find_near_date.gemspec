
lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "find_near_date/version"

Gem::Specification.new do |spec|
  spec.name          = "find_near_date"
  spec.version       = FindNearDate::VERSION
  spec.licenses      = ["Zlib"]
  spec.authors       = ["Narazaka"]
  spec.email         = ["info@narazaka.net"]

  spec.summary       = "find record by date from DB tables that is not indexed by date column"
  spec.homepage      = "https://github.com/Narazaka/find_near_date"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 4"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "onkcop"
  spec.add_development_dependency "rake", "~> 13.0"
end
