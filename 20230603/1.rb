# Dateクラスを使って、今月の１日と月末の日付と曜日を求め、次のような形式でカレンダーを表示させてください。

# June 2023
# Su Mo Tu We Th Fr Sa
#              1  2  3
#  4  5  6  7  8  9 10
# 11 12 13 14 15 16 17
# 18 19 20 21 22 23 24
# 25 26 27 28 29 30 

require 'date'

values = []

first_line = Date.today.strftime('%B %Y')
week_days = %w(Su Mo Tu We Th Fr Sa)

today = Date.today
year = today.year
month = today.month

first_wday = Date.new(year, month, 1).wday
last_day = Date.new(year, month, -1).day

puts first_line
puts week_days.join(' ')
print "   " * first_wday

w_day = first_wday
(1..last_day).each do |date|
    print date.to_s.rjust(2)
    w_day += 1
    if w_day % 7 == 0
        print "\n"
    else
        print ' '
    end
end
print "\n"

# このような日付の出力方法もある
# pp (1..last_day).chunk{ |day| (day + first_wday - 1).div(7) }.map(&:last)