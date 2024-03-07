# frozen_string_literal: true

require 'optparse'
require 'debug'

def main
  params = fetch_params
  paths = ARGV
  results = count_results(paths:)
  print_results(results:, params:)
  print_total(results:, params:) if multi_path?(results:)
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
    [fetch_counts(text: $stdin.read, path: '')]
  else
    paths.map { |path| fetch_counts(text: File.read(path), path:) }
  end
end

def fetch_counts(text:, path:)
  {
    lines: text.lines.count,
    words: text.split(/\s+/).size,
    textsize: text.bytesize,
    path:
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

def print_total(results:, params:)
  totals = count_totals(results:)
  print totals[:lines].to_s.rjust(8) if params[:l]
  print totals[:words].to_s.rjust(8) if params[:w]
  print totals[:textsize].to_s.rjust(8) if params[:c]
  print " total\n"
end

def count_totals(results:)
  totals = { lines: 0, words: 0, textsize: 0 }
  results.map do |result|
    totals[:lines] += result[:lines]
    totals[:words] += result[:words]
    totals[:textsize] += result[:textsize]
  end
  totals
end

main
