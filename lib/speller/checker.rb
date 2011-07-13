module Speller
  class Checker
    
    #Initialize ASpellSpeller, with the minimum required configuration, language. 
    #I'd like to refactor this to either take an ASpell_Config or just a language
    def initialize(aspell_config)
      possible_err = Speller::ASpell.new_aspell_speller(aspell_config)
      @spell_checker = Speller::ASpell.to_aspell_speller(possible_err)
    end

    def correct?(word)
        Speller::ASpell.speller_check(@spell_checker, word, word.length) == 1 ? true : false
    end
    
    def suggest(word)
      return [] if correct?(word)
      
      aspell_suggestions = Speller::ASpell.speller_suggest(@spell_checker, word, word.length)
      aspell_elements = Speller::ASpell.word_list_elements(aspell_suggestions)

      suggestions = []
      until ((word = Speller::ASpell.string_enumeration_next(aspell_elements)).nil?) do
        suggestions << word
      end
      return suggestions
    end
  
    def check_string(string, reset=false)
      reset ? @offset = 0 : @offset ||= 0
      puts @offset
      #if we've reached the end of the string
      return nil if @offset >= string.length + 1
      
      #build each word
      word = ""
      until string[@offset,1] == " " or @offset == (string.length) do #stop when we hit a word boundry
        word += string[@offset,1]
        @offset += 1
      end
      @offset += 1
      
      return check_string(string) if (word == " " || word == "")
      
      if !correct?(word)
        return [word, @offset - (word.length + 1), suggest(word)]
      else
        puts word
        return check_string(string)
      end
    end

  end
end

