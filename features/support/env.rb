require 'spec/expectations'
require 'fileutils'
require 'open3'

$root_dir = File.dirname(File.dirname(File.dirname(__FILE__)))
$forth_interpreter = File.join($root_dir, "forth")

def close_forth
  @forth_i.close unless @forth_i.nil?
  @forth_o.close unless @forth_o.nil?
  @forth_o.close unless @forth_e.nil?
end

def open_forth!
  close_forth
  # @forth_o, @forth_i = IO.pipe
  # pid = spawn($forth_interpreter, :in => @forth_o, :out => @forth_i, :err => @forth_i)
  # Process.detach(pid)
  @forth_o, @forth_i, @forth_e = Open3.popen3($forth_interpreter)
end

def open_forth
  open_forth! if @forth_i.nil? or @forth_o.nil?
end

