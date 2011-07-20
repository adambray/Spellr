module Speller
  class Checker
    
    def initialize(aspell_config)
      possible_err = Speller::ASpell.new_aspell_speller(aspell_config)
      @checker = Speller::ASpell.to_aspell_speller(possible_err)
    end

    def correct?(word)
        result = Speller::ASpell.speller_check(@checker, word, word.length)
        return result == 1 ? true : false
    end
    
    def suggest(word)
      return [] if correct?(word)
      
      aspell_suggestions = 
        Speller::ASpell.speller_suggest(@checker, word, word.length)
      
      aspell_elements = 
        Speller::ASpell.word_list_elements(aspell_suggestions)

      suggestions = []
      until ((word =
        Speller::ASpell.string_enumeration_next(aspell_elements)).nil?) do
        suggestions << word
      end
      
      Speller::ASpell.delete_aspell_string_enumeration(aspell_elements)
      return suggestions
    end
  
    def check_string(string, offset=nil)
      offset ? @offset = offset : @offset ||= 0
      
      # If we've reached the end of the string and found no errors
      return nil if @offset >= string.length + 1
      
      #build each word
      word = ""
      until string[@offset,1] =~ /\W/ or @offset == (string.length) do
        word += string[@offset,1]
        @offset += 1
      end
      @offset += 1
      
      # skip forward if somehow we've captured a non-word word
      return check_string(string) if (word =~ /\W/ || word == "")
      
      if !correct?(word)
        return [word, @offset - (word.length + 1), suggest(word)]
      else
        return check_string(string)
      end
    end

  end
end

