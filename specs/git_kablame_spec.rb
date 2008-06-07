require File.dirname(__FILE__) + '/spec_helper'

describe GitKablame, "processing a file" do              
  it "should count rows correctly" do
    gk = GitKablame.new('../test_data')
    gk.should_receive(:get_blame_lines).and_return(mock_blame("basic.rb", "git"))
    gk.process_file('../test_data/basic.rb.git') 
    out = capture_stdout { gk.print_results }.string       
    out.should =~ /Jacob Dunphy\s+==>\s+3/
    out.should =~ /Someone Else\s+==>\s+3/
  end
  
  it "should handle email addresses as author name" do
    gk = GitKablame.new('../test_data')
    gk.should_receive(:get_blame_lines).and_return(mock_blame("with-email.rb", "git"))
    gk.process_file('../test_data/with-email.rb.git') 
    out = capture_stdout { gk.print_results }.string       
    out.should =~ /Jacob Dunphy\s+==>\s+2/
    out.should =~ /Someone Else\s+==>\s+3/   
    out.should =~ /jdunphy@yp.com\s+==>\s+1/
  end           
  
  it "should handle whitespace around author names" do
    gk = GitKablame.new('../test_data')
    gk.should_receive(:get_blame_lines).and_return(mock_blame("with-odd-spacing.rb", "git"))
    gk.process_file('../test_data/with-odd-spacing.rb.git') 
    out = capture_stdout { gk.print_results }.string       
    out.should =~ /Jacob Dunphy\s+==>\s+3/
    out.should =~ /Someone Else\s+==>\s+3/
  end
  
end
