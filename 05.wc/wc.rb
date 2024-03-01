# frozen_string_literal: true

require 'optparse'
require 'debug'

def main
  pp params = fetch_params
  results = count_results(paths: ARGV)
end

def fetch_params
  opt = OptionParser.new
  params = {}
  opt.on('-l') { |v| params[:l] = v }
  opt.on('-w') { |v| params[:w] = v }
  opt.on('-c') { |v| params[:c] = v }
  opt.parse!(ARGV, into: params)
  params.empty? ? params = {l: true, w: true, c: true} : params 
end

def count_results(paths:)
  if paths.empty?
    pp fetch_count(text: $stdin.read, path: '')
  else
    pp paths.map {|f| fetch_count(text: File.read(f), path: f)}
  end
end

def fetch_count(text:, path:)
  {
    lines: text.lines.count,
    words: text.split(/\s+/).size,
    textsize: text.bytesize,
    path: path
  }
end


main
