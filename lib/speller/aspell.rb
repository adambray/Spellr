module Speller
  module ASpell
  
    extend FFI::Library
    ffi_lib ENV["ASPELL_LIB"] || "aspell"  
    
    def self.aspell_method(method_name,
      arguments,
      return_type,
      prefix = true)
                           
      c_method_name = (prefix ? "aspell_#{method_name}" : "#{method_name}")
      attach_function method_name, c_method_name, arguments, return_type
    end    
    

    typedef :pointer, :aspell_config
    typedef :pointer, :aspell_key_info
    

    # ASpell Config
    aspell_method :new_aspell_config,
      [],
      :aspell_config,
      false                     
    
    aspell_method :delete_aspell_config,
      [:aspell_config],
      :void,
      false             
    
    aspell_method :config_replace,
      [:aspell_config, :string, :string],
      :int        

    # Speller Management
    aspell_method :new_aspell_speller,
      [:pointer],
      :pointer,
      false
    
    aspell_method :to_aspell_speller,
      [:pointer],
      :pointer,
      false
    
    aspell_method :delete_aspell_speller,
      [:pointer],
      :void,
      false
        
    #Speller Functions
    aspell_method :speller_check,
      [:pointer, :string, :int],
      :int 
    
    aspell_method :speller_suggest,
      [:pointer, :string, :int],
      :pointer

    aspell_method :word_list_elements,
      [:pointer],
      :pointer
            
    aspell_method :string_enumeration_next,
      [:pointer],
      :string
    
    aspell_method :delete_aspell_string_enumeration,
      [:pointer],
      :void,
      false

    aspell_method :speller_add_to_personal,
      [:pointer, :string, :int],
      :int
    
    aspell_method :speller_add_to_session,
      [:pointer, :string, :int],
      :int
    
    aspell_method :speller_store_replacement,
      [:pointer, :string, :int, :string, :int],
      :int

  end
  
end