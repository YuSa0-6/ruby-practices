require 'optparse'
require 'Date'

options = ARGV.getopts('y:', 'm:')
year  = options["y"].nil? ? Date.today.year  : options["y"].to_i
month = options["m"].nil? ? Date.today.month : options["m"].to_i

puts "      #{month}月 #{year}"
puts "日 月 火 水 木 金 土"

first_date = Date.new(year, month, 1)
first_wday = first_date.wday
print "   " * first_wday

last_date = Date.new(year, month, -1)

(first_date..last_date).each do |date|
  day = date.day.to_s.center(3)
  if date.saturday?
    puts day
  else
    print day
  end
end

puts ""
