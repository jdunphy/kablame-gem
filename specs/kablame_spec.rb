require File.dirname(__FILE__) + '/spec_helper'

describe Kablame, "printing results" do
  it "should have a winner and loser" do
    kablame = GitKablame.new('test_data')
    kablame.stub!(:get_blame_lines).and_return(mock_blame("basic.rb", "git"))
    out = capture_stdout { kablame.kablame }.string  
    out.should =~ /\*\*WINNER\*\*.+\*\*WINNER\*\*/
    out.should =~ /\*\*LOSER\*\*.+\*\*LOSER\*\*/
  end
  
  it "should not have a loser if there is only one user" do
    kablame = GitKablame.new('test_data')
    out = capture_stdout { kablame.kablame }.string  
    out.should =~ /\*\*WINNER\*\*.+\*\*WINNER\*\*/
    out.should_not =~ /\*\*LOSER\*\*.+\*\*LOSER\*\*/
  end
end

describe Kablame, "handling multiple directories" do
  
  it "should accept multiple directories" do
    Kablame.stub!(:type).and_return('generic')
    Kablame.should_receive(:new).with(['lib', 'specs'], nil).and_return(mock('kablame', :kablame => true))
    capture_stdout { Kablame.kablame(['lib', 'specs'])}
  end
  
  it "should provide feedback about multiple directories" do
    output = capture_stdout { GitKablame.kablame(['lib', 'specs'])}.string
    
    output.should =~ /Kablaming lib/
    output.should =~ /Kablaming spec/
  end
  
end

describe Kablame, "parsing ARGV" do 
  it "should parse file formats" do
    Kablame.stub!(:type).and_return('generic')
    Kablame.should_receive(:new).with(['lib', 'specs'], ['xml', 'html']).and_return(mock('kablame', :kablame => true))
    capture_stdout { Kablame.kablame(['-f', 'xml,html', 'lib', 'specs'])}
  end  
  
end