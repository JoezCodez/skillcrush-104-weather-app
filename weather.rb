# Joe Krenicky
# 05/25/2015
# Ruby weather app
# Initial release

require 'yahoo_weatherman'

def get_zip ()
  stop = false
  while stop == false do
    puts "Please enter a 5 digit zip code: "
    zip_code = gets.chomp
    if zip_code.length != 5 then
      puts "\nPlease enter a zip code that is 5 numbers in length.\n"
    else 
      for i in 0..4 do
        if zip_code[i] == '0' || zip_code[i] == '1' || zip_code[i] == '2' || zip_code[i] == '3' || zip_code[i] == '4' || zip_code[i] == '5' || zip_code[i] == '6' || zip_code[i] == '7' || zip_code[i] == '8' || zip_code[i] == '9' then 
          stop = true
        else
          stop = false
          puts "\nPlease enter numbers only.\n"
          break
        end
      end
    end
  end 
  return zip_code 
end

def c_to_f (temp_c) 
  temp_f = ( temp_c * 9 / 5 ) + 32 
end

def print_weather(temp_today, condition_today, forecast)  
  puts "\nToday, the current weather condition is #{condition_today} and the temperature is #{c_to_f(temp_today)} F.\n"
  for day in 0..4 do
    puts "\n#{get_day(forecast[day]['day'],day)}, the forecast will be #{forecast[day]['text']} with a high of #{c_to_f(forecast[day]['high'])} F and a low of #{c_to_f(forecast[day]['low'])} F.\n"
  end
  puts "\n"
end

def get_day (day, i)
  if i == 0 then
    "Tomorrow"
  else
    days_of_week = {
      Sun: "Sunday",
      Mon: "Monday",
      Tue: "Tuesday",
      Wed: "Wednesday",
      Thu: "Thursday",
      Fri: "Friday",
      Sat: "Saturday"
    }
    days_of_week[day.to_sym]
  end
end

def main ()
  
  client = Weatherman::Client.new

  puts "\nHello! This is a Ruby Weather App.\n\n"

  zip_code = get_zip()

  temp_today = client.lookup_by_location(zip_code).condition['temp']
  condition_today = client.lookup_by_location(zip_code).condition['text']
  forecast = client.lookup_by_location(zip_code).forecasts

  print_weather(temp_today, condition_today, forecast)
  
end

main()