require 'optparse'
require 'Date'

options = ARGV.getopts('y:', 'm:')
year = options["y"].nil? ? Date.today.year : options["y"].to_i
month = options["m"].nil? ? Date.today.month : options["m"].to_i

puts "      #{month}月 #{year}"
puts "日 月 火 水 木 金 土"

first_wday = Date.new(year, month, 1).wday
print "   " * first_wday
last_day = Date.new(year, month, -1).day
next_sat = 7 - first_wday

# 参考：　https://docs.ruby-lang.org/ja/latest/method/String/i/center.html
(1..last_day).each do |d|
  if d == next_sat
    next_sat += 7
    puts d.to_s.center(3)
  else
    print d.to_s.center(3)
  end
end
puts ""
