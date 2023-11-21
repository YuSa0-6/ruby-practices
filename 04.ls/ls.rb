# frozen_string_literal: true

require 'optparse'

def main(row)
  files = find_files
  formatted_files = format_files(files)
  sorted_files = sort_files(formatted_files, row)
  display_files(sorted_files, row)
end

def find_files
  path = '*'
  r_option = false
  option = OptionParser.new
  option.on('-a') { path = '{.,*}{.,*}' }
  option.on('-r') { r_option = true }
  option.parse!(ARGV)
  r_option ? Dir.glob(path).reverse : Dir.glob(path)
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
