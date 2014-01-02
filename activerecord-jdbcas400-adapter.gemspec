# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "activerecord-jdbcas400-adapter"
  s.version     = "1.3.4.2"
  s.platform    = Gem::Platform::RUBY
  s.authors = ["Nick Sieger, Ola Bini, Pierrick Rouxel and JRuby contributors"]
  s.description = %q{Install this gem to use AS/400 with JRuby on Rails.}
  s.email = %q{nick@nicksieger.com, ola.bini@gmail.com}

  s.homepage = %q{https://github.com/pierrickrouxel/activerecord-jdbcas400-adapter}
  s.rubyforge_project = %q{jruby-extras}
  s.summary = %q{AS/400 JDBC adapter for JRuby on Rails.}

  s.require_paths = ["lib"]
  s.files = [
    "Rakefile", "README.md", "LICENSE.txt",
    *Dir["lib/**/*"].to_a
    ]
  s.test_files = *Dir["test/**/*"].to_a

  s.add_dependency 'activerecord-jdbc-adapter', ">= 1.3.4"
end
