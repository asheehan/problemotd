=begin
Bot Namer
A simple, fun one for today. We're building out the next triple A game for iOS and Android and we need to create a function that names the bots in our game. One way we can do this is by selecting an adjective and a noun and pairing them together for names like "Blue Dinosaur" or "Cool Cat". Today's problem is to create a bot namer for our game. If you have a more creative way of generating names please post your solution in the comments below.

Solution
grabbed some dictionary-type text files
=end
totalAdjectives = `wc -l adjectives/1syllableadjectives.txt`.split(' ')[0].to_i
totalNouns = `wc -l nouns/1syllablenouns.txt`.split(' ')[0].to_i
adj = File.readlines('adjectives/1syllableadjectives.txt')[rand(1..totalAdjectives)-1].strip
noun = File.readlines('nouns/1syllablenouns.txt')[rand(1..totalNouns)-1].strip
print "You are a #{adj} #{noun}\n"