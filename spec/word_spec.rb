require 'word'

RSpec.describe 'Word' do
  before() do
    Word.clear()
  end
  describe '#sort' do
    it 'will push a word object to the class array variable called dictionary' do
      new_word = Word.new('sushi')
      new_word.save
      new_word2 = Word.new('apple')
      new_word2.save
      expect(Word.sort).to eq [new_word2,new_word]
    end
  end
  describe '#save' do
    it 'will push a word object to the class array variable called dictionary' do
      new_word = Word.new('sushi')
      new_word.save
      expect(Word.all).to eq [new_word]
    end
  end
end
