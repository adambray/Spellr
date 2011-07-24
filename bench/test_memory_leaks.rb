require_relative '../lib/speller'

#GC.disable

def memory
  [Speller::ASpell, Speller::Checker, Speller::Config, FFI::Pointer, FFI::MemoryPointer].each { |c|
    puts "#{c}: #{ObjectSpace.each_object(c) {}}"
  }
  memory_used
  puts
end

def memory_used
  mem = `ps aux | grep #{$0}`.lines.inject(0) { |mem, line|
    mem + (line.split(/\s+/)[3].to_f / 100 * MEM)
  }
  puts "#{mem.round} MB"
  mem
end

MEM = 4140 # MB

memory



N = 20_000
N.times { |i|
  my_config = Speller::Config.new("en_US")
  my_config.set_value("ignore-case", "true")
  my_checker = Speller::Checker.new(my_config.config)
  my_checker.correct?("af")
  my_checker.correct?("wordd")
  my_checker.suggest("word")
  my_checker.suggest("wordd").join(", ")
  my_checker.check_string("Thiss is ??? a testt?.")
  
  if i % (N/25) == 0
    #GC.start
    p i
    memory
  end

}

memory

GC.start

memory