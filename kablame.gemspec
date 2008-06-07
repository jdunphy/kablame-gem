require 'rake'

Gem::Specification.new do |s|

  s.name = 'kablame'
  s.author = "Jacob Dunphy"
  s.version = '0.0.1'
  s.summary = 'Use svn or git blame to show you who deserves the credit'
  
  s.files = FileList['lib/*.rb', 'bin/*'].to_a
  s.autorequire = %q{templette}
  
  s.description = <<-EOF
          Counting lines of code based upon blame.
  EOF
  
  s.executables = ['kablame']
  s.default_executable = 'kablame'
  
  s.email = 'jacob.dunphy@gmail.com'
  
  s.has_rdoc = false
end
