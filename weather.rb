require 'barometer'

puts ''
puts 'What is your location? (give city name, airport code, or postal code)'
location = gets

def get_weather(location)
  Barometer.new(location).measure
end

weather = get_weather(location)
puts ''
puts 'The current weather is ' + weather.current.temperature.f.to_s + 'F and ' + weather.current.icon + '.'
puts ''
puts 'Tomorrow is going to be ' + weather.tomorrow.icon + ' with a high of ' + weather.tomorrow.high.f.to_s + 'F and a low of ' + weather.tomorrow.low.f.to_s + 'F.'
weather.forecast.each { |forecast|
  month = forecast.starts_at.month
  day = forecast.starts_at.day

  puts month.to_s + '/' + day.to_s + ' is going to be ' + forecast.icon + ' with a high of ' + forecast.high.f.to_s + 'F and a low of ' + forecast.low.f.to_s + 'F.'
}
puts ''


=begin this is the old code (for safe keeping!)
weather.forecast.each { |forecast|
  puts forecast.starts_at.month.to_s + '/' + forecast.starts_at.day.to_s + ' is going to be ' + forecast.icon + ' with a high of ' + forecast.high.f.to_s + 'F and a low of ' + forecast.low.f.to_s + 'F.'
}
=end
