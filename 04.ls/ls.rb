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

ROW = 3

def main
  l_option = false
  files = Dir.glob('*')
  option = OptionParser.new
  option.on('-a') { files = Dir.glob('{.,*}{.,*}') }
  option.on('-r') { files = files.reverse }
  option.on('-l') { l_option = true }
  option.parse!(ARGV)
  l_option ? long_format_files(files) : short_format_files(files)
end

def long_format_files(files)
  long_formated_files = files.map do |fs|
    long_name = ''
    fs_state = File.lstat(fs)
    mode = fs_state.mode.to_s(8)
    long_name += FILE_TYPE[fs_state.ftype]
    long_name << FILE_MODE[mode[3]]
    long_name << FILE_MODE[mode[4]]
    long_name << FILE_MODE[mode[5]]
    long_name << "  #{fs_state.nlink}"
    long_name << " #{Etc.getpwuid.name}"
    long_name << "  #{Etc.getgrgid.name}"
    long_name << "  #{fs_state.size.to_s.rjust(4)}"
    long_name << " #{File.mtime(fs).strftime('%_m %_d %H:%M')}"
    long_name << " #{fs}"
  end
  display_files(long_formated_files, 1)
end

def short_format_files(files)
  formatted_files = format_files(files)
  sorted_files = sort_files(formatted_files, ROW)
  display_files(sorted_files, ROW)
end

def format_files(files)
  most_long_name = files.max_by(&:length)
  files.map { |file| file.ljust(most_long_name.length + 4) }
end

def sort_files(files, row)
  sorted_files = []
  number_of_lines = (files.length.to_f / row).ceil
  number_of_lines.times do |col_index|
    row.times do |row_index|
      sorted_files << files[col_index + number_of_lines * row_index]
    end
  end
  sorted_files
end

def display_files(files, row)
  files.each_with_index { |file, index| print ((index + 1) % row).zero? ? "#{file}\n" : file }
end

main
