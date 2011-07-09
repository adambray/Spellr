require 'rubygems'
require 'ffi'

module ASpell
  
  extend FFI::Library
  #ffi_lib ENV["ASPELL_LIB"] || "aspell"
  ffi_lib "/usr/local/Cellar/aspell/0.60.6/lib/libaspell.dylib"
  
  attach_function 'new_aspell_config', [], :pointer
  attach_function 'aspell_config_replace', [:pointer, :string, :string], :void
  attach_function 'new_aspell_speller', [:pointer], :pointer
  attach_function 'to_aspell_speller', [:pointer], :pointer
  attach_function 'aspell_speller_check', [:pointer, :string, :int], :int
  attach_function 'aspell_speller_suggest', [:pointer, :string, :int], :pointer
  attach_function 'aspell_word_list_elements', [:pointer], :pointer
  attach_function 'aspell_string_enumeration_next', [:pointer], :string
  
end