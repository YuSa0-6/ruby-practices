require 'optparse'
require 'Date'

options = ARGV.getopts('y:', 'm:')
year = options[":y"].to_i
month = options[":m"].to_i
year = Date.today.year if options[":y"].nil?
month = Date.today.month if options[":m"].nil?

puts "      #{month}月 #{year}"
puts "日 月 火 水 木 金 土"

first_wday = Date.new(year, month, 1).wday
first_wday.times { print "   " }
last_day = Date.new(year, month, -1).day
next_sat = 7 - first_wday

## 右に空白が出力されるのでcenterを使う
(1..last_day).each do |d|
  if d == next_sat
    next_sat += 7
    puts d.to_s.center(3)
  else
    print d.to_s.center(3)
  end
end
puts ""
