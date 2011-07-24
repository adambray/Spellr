require 'strscan'

module Speller
  class Checker
    
    def initialize(aspell_config)
      possible_err = Speller::ASpell.new_aspell_speller(aspell_config)
      @checker = Speller::ASpell.to_aspell_speller(possible_err)
      
      ObjectSpace.define_finalizer( self, self.class.destroy(@checker) )
    end

    def correct?(word)
        return unless word
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
      @s = StringScanner.new(string)
      word_set = []

      while !@s.eos?      
        @s.scan(/\W+/)
        word = @s.scan(/\w+/)
        
        break if word.nil?
        
        if !correct?(word)
          word_set << [word, @s.pos - (word.length), suggest(word)]
        end
      
      end

      return word_set
    end
    
    def self.destroy(checker)
      proc { Speller::ASpell.delete_aspell_speller(checker) }
    end
    
  end
end

