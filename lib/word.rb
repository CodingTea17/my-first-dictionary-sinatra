class Word
  @@dictionary = []

  attr_reader :the_word, :definition

  def initialize(properties)
    @the_word = properties[:the_word]
    @definition = []
  end

  def self.sort()
    @@dictionary.sort
  end

end
