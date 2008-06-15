require 'optparse'

class KablameOptions
  
  def opts
    OptionParser.new do |opts|
      opts.banner = "Usage: #{@type}-kablame [options] <directories>"
      opts.on("-f", "--formats xml,html", Array, "List of file formats to #{@type}-kablame") do |list|
        @formats = list
      end
      
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end
    end
  end
  
  def initialize(type)
    @type = type
  end
  
  def format_parse(args)
    @formats = nil
    opts.parse!(args)
    @formats
  end
  
  def self.print_usage(type)
    puts self.new(type).opts
  end
end