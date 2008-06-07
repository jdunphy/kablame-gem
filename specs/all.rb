%w{spec_helper git_kablame_spec svn_kablame_spec}.each do |f|
  require File.dirname(__FILE__) + "/#{f}"
end
