# frozen_string_literal: true

# w(words), l(lines), c(--bytes) を実装する。
require 'optparse'
require 'debug'

def main
  params = fetch_params
  paths = fetch_paths
  display_result(paths, params)
end

def fetch_params
  opt = OptionParser.new
  params = {w: false, l: false, c: false}
  opt.on('-w') { |v| params[:w] = v }
  opt.on('-l') { |v| params[:l] = v }
  opt.on('-c') { |v| params[:c] = v }
  opt.parse!(ARGV, into: params)
  params = { w: true, l: true, c: true } if !params.values.any?
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

def display_result(file_paths, params)
  total = { lines: 0, words: 0, bytesize:0 }
  file_paths.map do |path|
    text = File.read(path)
    print "       #{lines = count_lines(text)}" if params[:l]
    print "       #{words = count_words(text)}" if params[:w]
    print "       #{bytesize = fetch_bytesize(path)}" if params[:c]
    puts " #{path}"
    total[:lines] += lines if params[:l]
    total[:words] += words if params[:w]
    total[:bytesize] += bytesize if params[:c]
  end
end

main
