module Speller
  class Config
    
    attr_reader :config
    
    def initialize(lang="en_US")
        @config = Speller::ASpell.new_aspell_config
        Speller::ASpell.config_replace(@config,"lang", lang)

        # Free memory from aspell config object when our 
        # Ruby object is destroyed by the GC
        ObjectSpace.define_finalizer( self, self.class.destroy(@config) )
    end

    def []= (key, value)
      Speller::ASpell.config_replace(@config, key, value)
    end
    
    def [](key)
      Speller::ASpell.config_retrieve(@config, key)
    end
    
    def self.destroy(config)
      proc { Speller::ASpell.delete_aspell_config(config) }
    end

  end
end
