# frozen_string_literal: true

require 'optparse'
require 'debug'

def main
  params = fetch_params
  results = count_results(paths: ARGV)
  print_results(results: results, params: params)
  p results[:path]
  print_total(results: results)
end

def fetch_params
  opt = OptionParser.new
  params = {}
  opt.on('-l') { |v| params[:l] = v }
  opt.on('-w') { |v| params[:w] = v }
  opt.on('-c') { |v| params[:c] = v }
  opt.parse!(ARGV, into: params)
  params.empty? ? params = { l: true, w: true, c: true } : params
end

def count_results(paths:)
  if paths.empty?
    fetch_count(text: $stdin.read, path: '')
  else
    paths.map { |path| fetch_count(text: File.read(path), path: path) }
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

def print_results(results:, params:)
  results.map do |result|
    print result[:lines].to_s.rjust(8) if params[:l]
    print result[:words].to_s.rjust(8) if params[:w]
    print result[:textsize].to_s.rjust(8) if params[:c]
    print " #{result[:path]}\n"
  end
end

def multi_path?(results:)
  results.length > 1
end

def print_total(results:)
  totals = count_totals(results: results)
  print totals[:lines].to_s.rjust(8)
  print totals[:words].to_s.rjust(8)
  print totals[:textsize].to_s.rjust(8)
  print " total\n"
end

def count_totals(results:)
  totals = {lines: 0, words: 0, textsize: 0}
  results.map do |result|
    totals[:lines] += result[:lines]
    totals[:words] += result[:words]
    totals[:textsize] += result[:textsize]
  end
  totals
end

main
