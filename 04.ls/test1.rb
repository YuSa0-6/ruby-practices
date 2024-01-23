require 'etc'
fs = File.lstat($0)
p fs.mode.to_s(8) #=> "100644" (8進数の文字列)
p fs.ftype #=> "file"　ファイルタイプ
p fs.nlink #=> "ハードリンク数"
p Etc.getpwuid.name #=> "所有者名"
p Etc.getgrgid.name #=> "グループ名"
p fs.rdev #=> "ファイルサイズ"
p 
