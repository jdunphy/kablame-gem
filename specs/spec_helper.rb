require 'rubygems'
gem 'rspec'
require 'spec'
require File.dirname(__FILE__) + '/../lib/kablame'

GEM_ROOT = File.expand_path(File.dirname(__FILE__) + '/../') unless defined?(GEM_ROOT)

Dir.chdir(GEM_ROOT)

def mock_blame(name, format)
  File.read(File.dirname(__FILE__) + "/../test_data/#{name.to_s}.#{format.to_s}") 
end
                  
                  
def capture_stdout  #copied out of ZenTest and reduced
  require 'stringio'
  orig_stdout = $stdout.dup
  captured_stdout = StringIO.new
  $stdout = captured_stdout
  yield
  captured_stdout.rewind
  return captured_stdout
ensure
  $stdout = orig_stdout
end                                   