# frozen_string_literal: true

require 'optparse'
require 'etc'

FILE_TYPE = {
  'fifio' => 'p',
  'characterSpecial' => 'c',
  'directory' => 'd',
  'blockSpecial' => 'b',
  'file' => '-',
  'link' => 'l',
  'socket' => 's'
}.freeze

FILE_MODE = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}.freeze

def main(row)
  formatted_files = format_files(files)
  sorted_files = sort_files(formatted_files, row)
  display_files(sorted_files, row)
end

def files
  path = '*'
  r_option = false
  l_option = false

  option = OptionParser.new
  option.on('-a') { path = '{.,*}{.,*}' }
  option.on('-r') { r_option = true }
  option.on('-l') { l_option = true }
  option.parse!(ARGV)

  if r_option
    Dir.glob(path).reverse
  elsif l_option
    set_long_format(path)
  else
    Dir.glob(path)
  end
end

def set_long_format(path)
  get_mode(Dir.glob(path))
  Dir.glob(path)
end

def get_mode(long_format_files)
  long_format_files.map do |fs|
    l_fs = File.lstat(fs)
    mode = l_fs.mode.to_s(8)
    print FILE_TYPE[l_fs.ftype]
    print FILE_MODE[mode[3]]
    print FILE_MODE[mode[4]]
    print FILE_MODE[mode[5]]
    print '  '
    print l_fs.nlink
    print ' '
    print Etc.getpwuid.name
    print '  '
    print Etc.getgrgid.name
    print ' '
    print l_fs.size.to_s.rjust(fs.length)
    print '  '
    print File.mtime(fs).strftime("%m %d %H:%M")
    print '  '
    print fs
    puts ""
  end
end

def format_files(files)
  most_long_name = files.max_by(&:length)
  files.map { |file| file.ljust(most_long_name.length + 4) }
end

def sort_files(formatted_files, row)
  sorted_files = []
  number_of_lines = (formatted_files.length.to_f / row).ceil
  number_of_lines.times do |col_index|
    row.times do |row_index|
      sorted_files << formatted_files[col_index + number_of_lines * row_index]
    end
  end
  sorted_files
end

def display_files(sorted_files, row)
  sorted_files.each_with_index { |file, index| print ((index + 1) % row).zero? ? "#{file}\n" : file }
end

main(3)
