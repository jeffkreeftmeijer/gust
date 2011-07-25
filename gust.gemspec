# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "gust"
  s.version     = '0.1.2'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jeff Kreeftmeijer"]
  s.email       = ["jeff@kreeftmeijer.nl"]
  s.homepage    = "https://github.com/jeffkreeftmeijer/gust"
  s.summary     = %q{Syntax highlighting and Markdown/Textile parsing}
  s.description = %q{Syntax highlighting and Markdown/Textile parsing}

  s.rubyforge_project = "gust"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', ['~> 2.0']
  s.add_dependency 'pygments.rb', ['~> 0.1']
  s.add_dependency 'redcarpet', ['~> 1.17']
  s.add_dependency 'RedCloth', ['~> 4.2']
end
