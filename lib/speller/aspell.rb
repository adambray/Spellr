module Speller
  module ASpell
  
    extend FFI::Library
    ffi_lib ENV["ASPELL_LIB"] || "aspell"  
        
    typedef :pointer, :aspell_config
    typedef :pointer, :aspell_can_have_error
    typedef :pointer, :aspell_speller
    typedef :pointer, :aspell_string_enumeration
    typedef :pointer, :aspell_word_list

    # ASpell Config
    attach_function :new_aspell_config,
      [],
      :aspell_config             
    
    attach_function :delete_aspell_config,
      [:aspell_config],
      :void    
    
    attach_function :config_replace, :aspell_config_replace,
      [:aspell_config, :string, :string],
      :int        

    attach_function :config_retrieve, :aspell_config_retrieve,
      [:aspell_config, :string],
      :string

    # Speller Management
    attach_function :new_aspell_speller,
      [:aspell_config],
      :aspell_can_have_error
    
    attach_function :to_aspell_speller,
      [:aspell_can_have_error],
      :aspell_speller
    
    attach_function :delete_aspell_speller,
      [:aspell_speller],
      :void
        
    #Speller Functions
    attach_function :speller_check, :aspell_speller_check,
      [:aspell_speller, :string, :int],
      :int 
    
    attach_function :speller_suggest, :aspell_speller_suggest,
      [:aspell_speller, :string, :int],
      :pointer

    attach_function :word_list_elements, :aspell_word_list_elements,
      [:aspell_word_list],
      :aspell_string_enumeration
            
    attach_function :string_enumeration_next, :aspell_string_enumeration_next,
      [:aspell_string_enumeration],
      :string
    
    attach_function :delete_aspell_string_enumeration,
      [:aspell_string_enumeration],
      :void

    attach_function :speller_add_to_personal, :aspell_speller_add_to_personal,
      [:aspell_speller, :string, :int],
      :int
    
    attach_function :speller_add_to_session, :aspell_speller_add_to_session,
      [:aspell_speller, :string, :int],
      :int
    
    attach_function :speller_store_replacement, :aspell_speller_store_replacement,
      [:aspell_speller, :string, :int, :string, :int],
      :int
  end
  
end