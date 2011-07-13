module Speller
  class Config
    
    attr_reader :config
    
    def initialize(lang="en_US")
        @config = Speller::ASpell.new_aspell_config
        Speller::ASpell.config_replace(@config,"lang", lang)
    end

    def value(key)
      config = Speller::ASpell::AspellKeyInfo.new(Speller::ASpell.config_keyinfo(@config, key))
      puts config[:name]
      puts config[:description]     
    end
    
    def destroy
      Speller::ASpell.delete_aspell_config(@config)
      @config = nil
    end

    

  end
end
