require 'rubygems'
require 'ffi'
require 'aspell-ffi'

spell_config = ASpell.new_aspell_config
ASpell.aspell_config_replace(spell_config,"lang", "en_US")

possible_err = ASpell.new_aspell_speller(spell_config)
spell_checker = ASpell.to_aspell_speller(possible_err)

is_correct = ASpell.aspell_speller_check(spell_checker, "spellling", 9)
puts is_correct

suggestions = ASpell.aspell_speller_suggest(spell_checker, "spellling", 9)
elements = ASpell.aspell_word_list_elements(suggestions)

until ((word = ASpell.aspell_string_enumeration_next(elements)).nil?) do
  puts word
end