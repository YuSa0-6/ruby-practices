# w(単語数), l(--max-line-length), c(--bytes) を実装する。
require 'optparse'

opt = OptionParser.new
params = {}
# params を受け取る
# FilePathを受け取る
opt.on('-w'){|v| params[:w] = v}
opt.on('-l'){|v| params[:l] = v}
opt.on('-c'){|v| params[:l] = v}
opt.parse!(ARGV, into: params)
p file_paths = ARGV
p params
# ファイルパスがない場合は標準入力に移る。(ARGV.empty?)
if ARGV.empty?
  p file_paths = $stdin.read.split("\n")
end

total = {lines: 0, words: 0, file_size: 0}
file_paths.map{|path|
  text = File.read(path)
  print total[:lines] += text.lines.count  # １.ファイル内の行数をカウントする
  print total[:words] += text.split(/\s+/).size  # ２.単語数をカウントする
  print total[:file_size] += File::Stat.new(path).size # ３.ファイル容量をカウントする
  puts path
  puts total
}

# if 複数ファイルの場合Totalを表示する。
puts total
