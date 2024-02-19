# frozen_string_literal: true

# w(words), l(lines), c(--bytes) を実装する。
require 'optparse'
require 'debug'

def main
  params = fetch_params
  file_paths = fetch_paths
  display_result(file_paths, params)
end

def fetch_params
  opt = OptionParser.new
  params = { w: false, l: false, c: false }
  opt.on('-w') { |v| params[:w] = v }
  opt.on('-l') { |v| params[:l] = v }
  opt.on('-c') { |v| params[:c] = v }
  opt.parse!(ARGV, into: params)
  params = { w: true, l: true, c: true } if params.values.none?
  params
end

def fetch_paths
  file_paths = ARGV
  file_paths = $stdin.read.split("\n") if file_paths.empty?
  file_paths
end

def count_lines(text)
  text.lines.count
end

def count_words(text)
  text.split(/\s+/).size
end

def fetch_bytesize(path)
  File::Stat.new(path).size
end

def display_total(total, params)
  print        total[:lines].to_s.rjust(8) if params[:l]
  print        total[:words].to_s.rjust(8) if params[:w]
  print        total[:bytesize].to_s.rjust(8) if params[:c]
  print " total\n"
end

def display_result(file_paths, params)
  total = { lines: 0, words: 0, bytesize: 0 }
  file_paths.map do |path|
    text = File.read(path)
    print count_lines(text).to_s.rjust(8) if params[:l]
    print count_words(text).to_s.rjust(8) if params[:w]
    print fetch_bytesize(path).to_s.rjust(8) if params[:c]
    puts " #{path}"
    total[:lines] += count_lines(text)
    total[:words] += count_words(text)
    total[:bytesize] += fetch_bytesize(path)
  end
  display_total(total, params) if file_paths.count > 1
end

main
