require 'rubygems'
require 'ffi'
require File.expand_path('../../lib/speller', __FILE__)

my_checker = Speller::Checker.new
puts my_checker.correct?("word")
puts my_checker.correct?("wordd")
puts my_checker.suggest("wordd").join(", ")
result = my_checker.check_string("This is a a testz")
if result
  puts "The word '#{result[0]}' is misspelled at offset #{result[1]}"
  puts "Suggested spellings: #{result[2].join(", ")}"
else
  puts "No mispellings found"
end