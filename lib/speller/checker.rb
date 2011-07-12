module Speller
  class Checker
    
    def initialize(lang = "en_US")
      @config = Speller::ASpellWrapper.new_aspell_config
      Speller::ASpellWrapper.aspell_config_replace(@config,"lang", lang)

      possible_err = Speller::ASpellWrapper.new_aspell_speller(@spell_config)
      @spell_checker = Speller::ASpellWrapper.to_aspell_speller(possible_err)
    end

    def correct?(word)
      Speller::ASpellWrapper.aspell_speller_check(@spell_checker, word, word.length) == 1 ? true : false
    end
    
    def suggest(word)
      aspell_suggestions = Speller::ASpellWrapper.aspell_speller_suggest(@spell_checker, word, word.length)
      aspell_elements = Speller::ASpellWrapper.aspell_word_list_elements(aspell_suggestions)

      suggestions = []
      until ((word = Speller::ASpellWrapper.aspell_string_enumeration_next(aspell_elements)).nil?) do
        suggestions << word
      end
      return suggestions
    end
  end
end