# Speller: Spell check using Ruby

Speller provides an interface (using ffi) to the GUN ASpell library. Currently, it offers the ability to check words or a string of words for correctness, and return suggestions.

##Usage

###Config
Before you can spell check a string, you need to set your configuration options. To do so, you create an instance of the Speller::Config class.

When creating an instance of Speller::Config, you must specify one arguement, the language code to be used:

	my_config = Speller::Config.new("en_US")

You can then set any additional configuration options using set_value:

	my_config.set_value("size", 5)

*For info on what options are available, see the [GNU ASpell Documentation](http://aspell.net/man-html/The-Options.html)*

Once you've set all your configuration options, create a new instance of Speller::Checker:

	my_checker = Speller::Checker.new(my_config.config)

**Note that you must set all options before creating a new Speller::Checker instance.**

###Checking Spelling

Speller:Checker has a couple of methods for checking spelling:

To check for correctness, use the `correct?` method:

	my_checker.correct?("word") 	#returns true
	my_checker.correct?("wordd")	#returns false

To get suggestions for a word, use the `suggest` method. This method returns the suggested corrections as an array of strings. If the word is spelled correctly, it returns an empty array.

	my_checker.suggest("word")
	my_checker.suggest("wordd")


To check an entire string, use the `check_string` method, providing the string to check, and an optional integer offset indicating where to begin checking. If no offset is provided, the method will check from the beginning of the string.

The `check_string` method returns an array with three elements. The first element is a string of the first misspelled word detected; the second is the offset at which the word was found; the third is an array of suggested corrections.

If no misspellings are found, `check_string` returns `nil`.

	string = "This longg string has two misspelled words. The secondd misspelling is in the second sentence."
	
	result = my_checker.check_string(string)
	if result
  		puts "The word '#{result[0]}' is misspelled at offset #{result[1]}"
  		puts "Suggested spellings: #{result[2].join(", ")}"
	else
		puts "No mispellings found"
	end