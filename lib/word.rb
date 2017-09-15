require 'hashids'
class Word
  @@dictionary = []

  # Passes a unique value so this applications hashes are unique!
  @@hashids = Hashids.new("codingtea17")

  attr_reader :the_word, :definition, :creation, :id

  def initialize(new_word)
    @the_word = new_word
    @definition = []
    # Generates an id for this word by encoding the Time is was created which can be decoded for later use!
    @id = @@hashids.encode(Time.new)
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

  def self.find(id)
    @@dictionary.each do |word|
      if word.id == id
        return word
      end
    end
  end

  def save()
    # built in duplicate word checker
    @@dictionary.each do |word|
      if word.the_word.downcase == self.the_word.downcase
       return false
     end
    end
    @@dictionary.push(self)
  end

  def add_definition(a_definition)
    @definition.push({:definition => "\"" + a_definition + "\"", :timestamp => Time.new})
  end

  def self.time_sift()
      temp_dict = @@dictionary.sort_by {|word| @@hashids.decode(word.id)[0]}
      temp_dict.last
    end

  def decodr()
    Time.at(@@hashids.decode(self.id)[0]).strftime("%m/%d/%Y %l:%M %p")
  end
end
