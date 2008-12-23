Gem::Specification.new do |s|
  s.name = %q{tobirex}
  s.version = "0.0.2"
 
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["mallowlabs"]
  s.date = %q{2008-12-24}
  s.default_executable = %q{tobirex}
  s.description = %q{Token based Intermediate representation with XML.}
  s.email = ["mallowlabs@gmail.com"]
  s.executables = ["tobirex"]
  s.extra_rdoc_files = ["README"]
  s.files = ["README", "bin/tobirex", "lib/tobirex.rb", "lib/tobirex/parser.rb", "lib/tobirex/plugin/javascript.rex", "lib/tobirex/plugin/javascript.rex.rb",  "test/test_tobirex.rb",  "test/test.js"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/mallowlabs/tobirex/tree/master}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{frex}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Token based Intermediate representation with XML.}
 
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2
 
    if current_version >= 3 then
    else
    end
  else
  end
end
