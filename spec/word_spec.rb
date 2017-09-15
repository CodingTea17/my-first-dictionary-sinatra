require 'word'

RSpec.describe 'Word' do
  before() do
    Word.clear()
  end
  describe '.time_sift' do
    it 'will return the last item added to the dictionary using it\'s timestamp encoded id' do
      new_word = Word.new('sushi')
      new_word.save
      new_word2 = Word.new('curry')
      new_word2.save
      expect(Word.time_sift).to eq new_word2
    end
  end
  describe '.sort' do
    it 'will alphabetically sort the entire dictionary' do
      new_word = Word.new('sushi')
      new_word.save
      new_word2 = Word.new('curry')
      new_word2.save
      expect(Word.sort).to eq [new_word2,new_word]
    end
  end
  describe '.find' do
    it 'will find a word from the dictionary by it\'s encoded id' do
      sushi_word = Word.new('sushi')
      sushi_word.save
      sushi_id = sushi_word.id
      new_word = Word.new('curry')
      new_word.save
      expect(Word.find(sushi_id)).to eq sushi_word
    end
  end
  describe '#save' do
    it 'will push a word object to the class array variable called dictionary' do
      new_word = Word.new('sushi')

      expect(new_word.save).to eq "saved"
    end
  end
  describe '#add_definition' do
    it 'will push a definition (and it\'s timestamp to a words definition array' do
      new_word = Word.new('sushi')
      new_word.add_definition("A delicious meal typically involving rice, nori, and raw fish")
      expect(new_word.definition[0][:definition]).to eq "\"A delicious meal typically involving rice, nori, and raw fish\""
    end
  end
  describe '#decodr' do
    it 'return the decoded id as a timestamp' do
      new_word = Word.new('sushi')
      time = Time.new # May fail once in a blue moon because it's possible that the second will have changed before it is declared and they will be different
      expect(new_word.decodr).to eq time.strftime("%m/%d/%Y %l:%M %p")
    end
  end
end
