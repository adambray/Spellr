module Speller
  module ASpell
  
    extend FFI::Library
    ffi_lib ENV["ASPELL_LIB"] || "aspell"  
    
    def self.aspell_method(method_name, arguments, return_type, prefix_aspell = true)
      c_method_name = (prefix_aspell ? "aspell_#{method_name}" : "#{method_name}")
      attach_function method_name, c_method_name, arguments, return_type
    end
    
    
    
    #ASpell Config
    aspell_method :new_aspell_config,
      [],
      :pointer,
      false
    
    
    #aspell_method :new_aspell_config, [], :pointer
    aspell_method :config_replace, [:pointer, :string, :string], :void
    aspell_method :delete_aspell_config, [:pointer], :void, false
    aspell_method :config_clone, [:pointer], :pointer
    aspell_method :config_error_number, [:pointer], :uint
    aspell_method :config_error_message, [:pointer], :string
    aspell_method :config_error, [:pointer], :pointer

    #ASpell Key Enumeration
    aspell_method :key_info_enumeration_at_end, [:pointer], :int
    aspell_method :key_info_enumeration_next, [:pointer] , :pointer
    aspell_method :delete_aspell_key_info_enumeration, [:pointer], :void, false
    aspell_method :key_info_enumeration_clone, [:pointer], :pointer


    #Speller Management
    aspell_method :new_aspell_speller, [:pointer], :pointer, false #takes AspellConfig, returns AspellCanHaveError
    aspell_method :to_aspell_speller, [:pointer], :pointer, false #takes AspellCanHaveError, returns AspellSpeller
    aspell_method :delete_aspell_speller, [:pointer], :void, false
    
    #Speller Errors
    aspell_method :speller_error_number, [:pointer], :uint #takes AspellSpeller
    aspell_method :speller_error_message, [:pointer], :string #takes AspellSpeller
    
    #Speller Functions
    aspell_method :speller_check, [:pointer, :string, :int], :int 
    aspell_method :speller_suggest, [:pointer, :string, :int], :pointer

    aspell_method :word_list_elements, [:pointer], :pointer
    aspell_method :word_list_empty, [:pointer], :int
    aspell_method :word_list_size, [:pointer], :uint
    aspell_method :speller_save_all_word_lists, [:pointer], :int
    aspell_method :speller_clear_session, [:pointer], :int

    aspell_method :string_enumeration_next, [:pointer], :string
    aspell_method :delete_aspell_string_enumeration, [:pointer], :void, false

    aspell_method :speller_add_to_personal, [:pointer, :string, :int], :int
    aspell_method :speller_add_to_session, [:pointer, :string, :int], :int
    aspell_method :speller_store_replacement, [:pointer, :string, :int, :string, :int], :int

  end
  
end