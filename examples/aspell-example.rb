require 'rubygems'
require 'ffi'
require File.expand_path('../../lib/speller', __FILE__)

#Create a new Checker object
my_config = Speller::Config.new("es_US")

my_config["ignore-case"] = "true"
my_config["lang"] = "en_US"

puts my_config["ignore-case"]
puts my_config["lang"]

my_checker = Speller::Checker.new(my_config.config)

#Checks if a word is correct
puts my_checker.correct?("af")
puts my_checker.correct?("wordd")

#Returns an array of suggestions, nil if the word is correct
#Should it be an empty array instead?
puts my_checker.suggest("word")
puts my_checker.suggest("wordd").join(", ")


#Check a whole string, returns the word, offset, and suggestions for the first mispelled word
results = my_checker.check_string("Thiss is ??? a testt?.")

results.each do |result|
		puts "The word '#{result[0]}' is misspelled at offset #{result[1]}"
		puts "Suggested spellings: #{result[2].join(", ")}"
end

