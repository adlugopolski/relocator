lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "relocator/version"

Gem::Specification.new do |spec|
  spec.name = "relocator"
  spec.version = Relocator::VERSION
  spec.authors = ["Aleksander Długopolski"]
  spec.email = ["aleks@dotpro.org"]
  spec.summary = "Command line utility to move classes in Ruby projects"
  spec.homepage = "https://github.com/adlugopolski/relocator"
  spec.bindir = "exe"
  spec.executables = ["relocator"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.8"
  spec.add_development_dependency "thor", "~> 0.20"

  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    %x[git ls-files -z].split("\x0").reject do |filename|
      filename.match(%r{^(test|spec|features)/})
    end
  end
end
