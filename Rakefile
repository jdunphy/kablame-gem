namespace :gem do
  desc "Build the gem"
  task( :build => :clean ) { `gem build kablame.gemspec` }

  desc "Clean build artifacts"
  task( :clean ) { FileUtils.rm_rf Dir['*.gem'] }    
end

desc("Run the specs")
task(:spec) { system 'ruby specs/all.rb' }

namespace :rdoc do
  desc "Clean rdoc"
  task(:clean) { FileUtils.rm_rf 'doc' }
  
  desc("Generate rdoc")
  task(:build => :clean) { system 'rdoc README MIT-LICENSE CHANGELOG lib'}
end 