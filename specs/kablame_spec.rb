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