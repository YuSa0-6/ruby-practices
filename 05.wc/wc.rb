# w(単語数), l(--max-lines-length), c(--bytes) を実装する。
require 'optparse'

def main
  params = fetch_params
  paths = fetch_paths
  display_result(paths, params)
end
def fetch_params
  opt = OptionParser.new
  params = {w: false, l: false, c: false}
  opt.on('-w'){|v| params[:w] = v}
  opt.on('-l'){|v| params[:l] = v}
  opt.on('-c'){|v| params[:c] = v}
  opt.parse!(ARGV, into: params)
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

def fetch_bytes(path)
  File::Stat.new(path).size
end

def display_result(file_paths, params)
  total = {lines: 0, words: 0, file_size: 0}
  file_paths.map{|path|
    text = File.read(path)
    print lines = count_lines(text) 
    print words = count_words(text)
    print file_size = fetch_bytes(path)
    puts path
    total[:lines] += lines
    total[:words] += words
    total[:file_size] += file_size
  }
  print file_paths.count > 1 ? "#{total[:lines]}  #{total[:words]}  #{total[:file_size]}  total\n" : nil
end

main
