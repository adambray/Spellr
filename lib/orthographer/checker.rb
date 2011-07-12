module Orthographer
  class Checker
    
    def initialize(lang = "en_US")
      @config = Orthographer::ASpellWrapper.new_aspell_config
      Orthographer::ASpellWrapper.aspell_config_replace(@config,"lang", lang)

      possible_err = Orthographer::ASpellWrapper.new_aspell_speller(@spell_config)
      @spell_checker = Orthographer::ASpellWrapper.to_aspell_speller(possible_err)
    end

    def correct?(word)
      Orthographer::ASpellWrapper.aspell_speller_check(@spell_checker, word, word.length) == 1 ? true : false
    end
    
    def suggest(word)
      aspell_suggestions = Orthographer::ASpellWrapper.aspell_speller_suggest(@spell_checker, word, word.length)
      aspell_elements = Orthographer::ASpellWrapper.aspell_word_list_elements(aspell_suggestions)

      suggestions = []
      until ((word = Orthographer::ASpellWrapper.aspell_string_enumeration_next(aspell_elements)).nil?) do
        suggestions << word
      end
      return suggestions
    end
  end
end