require File.dirname(__FILE__) + '/spec_helper'

describe SvnKablame, "processing a file" do              
  it "should count rows correctly" do
    gk = SvnKablame.new('../test_data')
    gk.should_receive(:get_blame_lines).and_return(mock_blame("basic.rb", "svn"))
    gk.process_file('../test_data/basic.rb.svn') 
    out = capture_stdout { gk.print_results }.string       
    out.should =~ /jacob.dunphy\s+==>\s+6/
    out.should =~ /se@else.com\s+==>\s+2/
  end
  
  it "should handle email addresses as author name" do
    gk = SvnKablame.new('../test_data')
    gk.should_receive(:get_blame_lines).and_return(mock_blame("basic.rb", "svn"))
    gk.process_file('../test_data/basic.rb.svn') 
    out = capture_stdout { gk.print_results }.string       
    out.should =~ /jacob.dunphy\s+==>\s+6/
    out.should =~ /se@else.com\s+==>\s+2/
  end           
    
end