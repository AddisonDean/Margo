lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative 'lib/margo/version'

Gem::Specification.new do |spec|
  spec.name          = 'margo'
  spec.version       = Margo::VERSION
  spec.authors       = ['Addison Dean']
  spec.email         = ['addison.dean.su@gmail.com']

  spec.summary       = 'Simple collision detector.'
  spec.description   = "Calculates boundary lines of object(s) based on input
                        coordinates, detects collisions between these boundaries
                        and a moving object based on that object's coordinates,
                        returns a boolean value."
  # spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = 'MIT'
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem
  # that have been added into git.
  spec.files         = `git ls-files`.split("\n")
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
