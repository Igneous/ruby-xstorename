#!/usr/bin/env ruby
require 'mkmf'

def get_xlib_path
  exes = find_xorg_exes
  libpaths = Array.new
  exes.each do |exe|
    if is_wrapper_script?(exe)
      exe_path = extract_exe_from_wrapper(exe)
      libpaths << `#{exe_path} -showDefaultLibPath 2>&1`.chomp
    else
      path = `#{exe} -showDefaultLibPath 2>&1`.chomp
      libpaths << path if File.directory?(path)
    end
  end

  libpaths.uniq.first
end

# is_wrapper? takes a filepath (String)
def is_wrapper_script?(filepath)
  firstline = File.open(filepath) { |f| f.readline }
  not firstline.match(/^#!/).nil?
end

# Returns an array of all files in $PATH that are named "X11", "Xorg", or "X"
def find_xorg_exes
  ENV['PATH'].split(':').flat_map { |dir| Dir.glob dir + "/**/{X11,Xorg,X}" }
    .find_all { |f| File.file?(f) }
end

def extract_exe_from_wrapper(filepath)
  lines   = File.readlines(filepath).map { |l| l.chomp }
  basedir = lines.collect { |l| l.match(/^basedir=(.*)$/) }.compact.first[1]
  exe     = lines.collect { |l| l.match(/exec\s+".*\/(.*)\s+/) }.compact.last[1]
  "#{basedir}/#{exe}"
end

extension_name = 'XStoreName'

$LOCAL_LIBS << "-lX11 -L#{get_xlib_path}"

dir_config(extension_name)
create_header
create_makefile(extension_name)
