require 'rake'

Gem::Specification.new do |s|

  s.name = 'kablame'
  s.author = "Jacob Dunphy"
  s.version = '0.2.0'
  s.summary = 'Use svn or git blame to show you who deserves the credit'
  
  s.files = FileList['lib/kablame.rb', 'lib/kablame_options.rb', 'bin/git-kablame','bin/svn-kablame']
  
  s.description = <<-EOF
          Counting lines of code based upon blame.
  EOF
  
  s.executables = ['git-kablame', 'svn-kablame']
  
  s.homepage = 'http://github.com/jdunphy/kablame-gem/tree/master'
  s.rubyforge_project = 'kablame'
  s.email = 'jacob.dunphy@gmail.com'  
  s.has_rdoc = true
end
