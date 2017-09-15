class Word
  @@dictionary = []

  attr_reader :the_word, :definition, :creation

  def initialize(new_word)
    @the_word = new_word
    @definition = []
    @creation = Time.new
  end

  def self.clear()
    @@dictionary = []
  end

  def self.sort()
    @@dictionary.sort_by {|word| word.the_word.downcase}

  end

  def self.all()
    @@dictionary
  end

  def save()
    @@dictionary.push(self)
  end
end
