require 'kablame_options'
class Kablame

  def initialize(dirs = nil, formats = nil)
    @users = {}    
    @folders = dirs.map {|dir| dir.sub(/\/+\Z/, '') }
    @formats = formats || %w{rb}
  end
  
  def kablame
    folders.each do |directory|
      if File.exists?(directory) 
        puts "\nKablaming #{directory}"
        Dir.glob(directory+"/**/*").grep(file_format_regex).each do |filename|
          process_file(filename.sub(/^\.\//, ''))
        end
      else
        puts "#{directory} not found. Skipping it!"
      end
    end
    unless(@users.empty?)
      print_results 
    else
      puts "No results.  Try a different directory?"
    end
  end 
  
  def self.kablame(args)
    formats = KablameOptions.new(type).format_parse(args)
    targets = args

    if targets.nil? || targets.empty?
    	KablameOptions.print_usage(type)
    	exit(0)
    end
    new(targets, formats).kablame
  end
  
  def process_file(filename)
    print '.'
    STDOUT.flush
    get_blame_lines(filename).each do |line|
      next if line.match(blank_line_regex)
      name = line.match(name_match_regex)[1].strip  
      (@users[name] ? @users[name].increment : @users[name] = KablameUser.new(name)) unless name.nil?
    end
  end

  def print_results
    puts "\n\n++++++++++++TOTALS++++++++++++"
    puts "**WINNER** #{@users.values.sort.first.name} **WINNER**"
    @users.values.sort.each do |user|
      puts user.to_s
    end 
    puts "**LOSER** #{@users.values.sort.last.name} **LOSER**" unless @users.length == 1
  end
  
  private  
  
    def folders 
      @folders
    end
  
    def file_format_regex
      %r{\.(#{@formats.join('|')})}
    end
  
end

class SvnKablame < Kablame

  def self.type; 'svn'; end

  private

    def blank_line_regex; /\d+[\ ]+(\w+)+(\s+)$/; end
  
    def name_match_regex; /\d+[\ ]+([\w@\.\-]+)/; end
 
    def get_blame_lines(filename)
      `svn blame #{filename}`.split("\n")
    end
    
end

class GitKablame < Kablame    
     
  def self.type; 'git'; end
  
  private
  
    def blank_line_regex; /\(.+[\+-]\d{4}\s+\d+\)(\s*)$/; end
  
    def name_match_regex; /\(([^\)]+)\s+\d{4}\-\d{2}/; end   
  
    def get_blame_lines(filename)
      `git blame #{filename}`.split("\n")
    end
end

class KablameUser
  attr_accessor :line_count
  attr_accessor :name

  def initialize(name)   
    @line_count = 1
    @name = name
  end

  def to_s
    "#{@name.ljust(20)} ==> #{@line_count.to_s.rjust(4)}"
  end

  def increment
    @line_count = @line_count.next
  end
  
  private

    def <=>(other)
      other.line_count <=> @line_count
    end
  
end