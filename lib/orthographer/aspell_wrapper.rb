module Orthographer
  module ASpellWrapper
  
    extend FFI::Library
    ffi_lib ENV["ASPELL_LIB"] || "aspell"  
    
    #ASpell Config
    attach_function 'new_aspell_config', [], :pointer
    attach_function 'aspell_config_replace', [:pointer, :string, :string], :void
    attach_function 'delete_aspell_config', [:pointer], :void
    attach_function 'aspell_config_clone', [:pointer], :pointer
    attach_function 'aspell_config_error_number', [:pointer], :uint
    attach_function 'aspell_config_error_message', [:pointer], :string
    attach_function 'aspell_config_error', [:pointer], :pointer

    #ASpell Key Enumeration
    attach_function 'aspell_key_info_enumeration_at_end', [:pointer], :int
    attach_function 'aspell_key_info_enumeration_next', [:pointer] , :pointer
    attach_function 'delete_aspell_key_info_enumeration', [:pointer], :void
    attach_function 'aspell_key_info_enumeration_clone', [:pointer], :pointer


    #Speller Management
    attach_function 'new_aspell_speller', [:pointer], :pointer #takes AspellConfig, returns AspellCanHaveError
    attach_function 'to_aspell_speller', [:pointer], :pointer #takes AspellCanHaveError, returns AspellSpeller
    attach_function 'delete_aspell_speller', [:pointer], :void
    
    #Speller Errors
    attach_function 'aspell_speller_error_number', [:pointer], :uint #takes AspellSpeller
    attach_function 'aspell_speller_error_message', [:pointer], :string #takes AspellSpeller
    
    #Speller Functions
    attach_function 'aspell_speller_check', [:pointer, :string, :int], :int 
    attach_function 'aspell_speller_suggest', [:pointer, :string, :int], :pointer

    attach_function 'aspell_word_list_elements', [:pointer], :pointer
    attach_function 'aspell_word_list_empty', [:pointer], :int
    attach_function 'aspell_word_list_size', [:pointer], :uint
    attach_function 'aspell_speller_save_all_word_lists', [:pointer], :int
    attach_function 'aspell_speller_clear_session', [:pointer], :int

    attach_function 'aspell_string_enumeration_next', [:pointer], :string
    attach_function 'delete_aspell_string_enumeration', [:pointer], :void

    attach_function 'aspell_speller_add_to_personal', [:pointer, :string, :int], :int
    attach_function 'aspell_speller_add_to_session', [:pointer, :string, :int], :int
    attach_function 'aspell_speller_store_replacement', [:pointer, :string, :int, :string, :int], :int

  end
  
end