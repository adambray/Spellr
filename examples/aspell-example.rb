require 'rubygems'
require 'ffi'
require File.expand_path('../../lib/speller', __FILE__)

my_checker = Speller::Checker.new
puts my_checker.correct?("word")
puts my_checker.correct?("wordd")
puts my_checker.suggest("wordd")