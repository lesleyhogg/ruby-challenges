require 'barometer'
require 'date'

puts ''
puts 'What is your location? (give city name, airport code, or postal code)'
location = gets.chomp.upcase

def get_weather(location)
  Barometer.new(location).measure
end

weather = get_weather(location)
puts ''
puts "The current weather in #{location} is " + weather.current.temperature.f.to_s + 'F and ' + weather.current.icon + '.'
puts ''

weather.forecast.each { |forecast|
  yy = forecast.starts_at.year
  mm = forecast.starts_at.month
  dd = forecast.starts_at.day
  daynum = Date.parse("#{yy}-#{mm}-#{dd}").wday
  dayname = ''

  case daynum
  when 0
    dayname = 'Sunday '
  when 1
    dayname = 'Monday '
  when 2
    dayname = 'Tuesday '
  when 3
    dayname = 'Wednesday '
  when 4
    dayname = 'Thursday '
  when 5
    dayname = 'Friday '
  when 6
    dayname = 'Saturday '
  end

  puts dayname.to_s + mm.to_s + '/' + dd.to_s + ' is going to be ' + forecast.icon + ' with a high of ' + forecast.high.f.to_s + 'F and a low of ' + forecast.low.f.to_s + 'F.'
}
puts ''
