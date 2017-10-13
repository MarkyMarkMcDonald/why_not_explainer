
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "why_not_explainer/version"

Gem::Specification.new do |spec|
  spec.name          = "why_not_explainer"
  spec.version       = WhyNotExplainer::VERSION
  spec.authors       = ["Mark McDonald"]
  spec.email         = ["mark.mcdonald.ga@gmail.com"]

  spec.summary       = 'Explains why a row was excluded by an Active Record relation'
  spec.description   = 'Re-runs select queries with different combinations of where clauses' \
                       'to determine which clause is filtering out a specific record.'
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "activerecord", '~> 4.2.10'
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "standalone_migrations", '~> 4.0.5'

  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
