=begin
Weighted Dice
Many people have lost money while gambling. We have no desire to lose money though. Today's goal is to create a program that random rolls two dice and outputs the value of each die. The trick is that each die must should show 1 at least 1/3 of the time. Make an attempt to obfuscate your code so that anyone looking at it won't notice that the program is rigged to roll snake eyes more often.

Solution
Pretty happy with this one. To obfuscate my code, I decided to pull a random sample webpage and pull all the numbers out of it. Benford's Law (http://en.wikipedia.org/wiki/Benford's_law) says that we'll have '1' at least 30% of the time (dropping the other numbers will push this over the one third threshold).
=end

require 'rubygems'
require 'nokogiri'
require 'open-uri'

# get random seed via website with text/numbers
uri = 'http://www.nytimes.com/'
random = Nokogiri::HTML(open(uri)).text

# iterate through digits and filter out non 1-6 numbers
rolls = Array.new
random.gsub(/\D/, '').each_char do |d|
  d = d.to_i
  if d >= 1 and d <= 6
    rolls.push(d)
  end
end

#randomly roll a dice
puts rolls[rand(rolls.length)]
puts rolls[rand(rolls.length)]
