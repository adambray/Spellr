require 'rubygems'
require 'ffi'
require File.expand_path('../../lib/orthographer', __FILE__)

my_checker = Orthographer::Checker.new
puts my_checker.correct?("word")
puts my_checker.correct?("wordd")
puts my_checker.suggest("wordd")