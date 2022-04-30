require_relative 'test_helper'

describe Rudachi::FileParser do
  before do
    File.open('./input.txt', 'w') do |f|
      f << '東京都へ行く'
    end
  end

  after do
    File.delete('./input.txt')
  end

  describe '.parse' do
    subject { Rudachi::FileParser.parse('./input.txt') }

    it 'returns analyzed words' do
      expect(subject).must_be_kind_of(String)
      expect(subject.split(?\n)).must_equal([
        "東京都\t名詞,固有名詞,地名,一般,*,*\t東京都",
        "へ\t助詞,格助詞,*,*,*,*\tへ",
        "行く\t動詞,非自立可能,*,*,五段-カ行,終止形-一般\t行く",
        "EOS"
      ])
    end

    describe 'when with "o" option' do
      before do
        Rudachi::Option.configure do |config|
          config.o = './output.txt'
        end
      end

      after do
        File.delete('./output.txt')
        Rudachi::Option.configure do |config|
          config.o = nil
        end
      end

      it 'writes analyzed words to a output file' do
        expect(subject).must_equal('')
        expect('./output.txt').path_must_exist
        output = File.read('./output.txt')
        expect(output.split(?\n)).must_equal([
          "東京都\t名詞,固有名詞,地名,一般,*,*\t東京都",
          "へ\t助詞,格助詞,*,*,*,*\tへ",
          "行く\t動詞,非自立可能,*,*,五段-カ行,終止形-一般\t行く",
          "EOS"
        ])
      end
    end

    describe 'when with "m" option' do
      before do
        Rudachi::Option.configure do |config|
          config.m = 'A'
        end
      end

      after do
        Rudachi::Option.configure do |config|
          config.m = 'C'
        end
      end

      it 'returns analyzed words by mode "A"' do
        expect(subject).must_be_kind_of(String)
        expect(subject.split(?\n)).must_equal([
          "東京\t名詞,固有名詞,地名,一般,*,*\t東京",
          "都\t名詞,普通名詞,一般,*,*,*\t都",
          "へ\t助詞,格助詞,*,*,*,*\tへ",
          "行く\t動詞,非自立可能,*,*,五段-カ行,終止形-一般\t行く",
          "EOS"
        ])
      end
    end
  end

  describe '#parse' do
    subject { Rudachi::FileParser.new(**opts).parse('./input.txt') }

    let(:opts) { {} }

    it 'returns analyzed words' do
      expect(subject).must_be_kind_of(String)
      expect(subject.split(?\n)).must_equal([
        "東京都\t名詞,固有名詞,地名,一般,*,*\t東京都",
        "へ\t助詞,格助詞,*,*,*,*\tへ",
        "行く\t動詞,非自立可能,*,*,五段-カ行,終止形-一般\t行く",
        "EOS"
      ])
    end

    describe 'when with "o" option' do
      let(:opts) { {o: './output.txt'} }

      after { File.delete('./output.txt') }

      it 'writes analyzed words to a output file' do
        expect(subject).must_equal('')
        expect('./output.txt').path_must_exist
        output = File.read('./output.txt')
        expect(output.split(?\n)).must_equal([
          "東京都\t名詞,固有名詞,地名,一般,*,*\t東京都",
          "へ\t助詞,格助詞,*,*,*,*\tへ",
          "行く\t動詞,非自立可能,*,*,五段-カ行,終止形-一般\t行く",
          "EOS"
        ])
      end
    end

    describe 'when with "m" option' do
      let(:opts) { {m: 'A'} }

      it 'returns analyzed words by mode "A"' do
        expect(subject).must_be_kind_of(String)
        expect(subject.split(?\n)).must_equal([
          "東京\t名詞,固有名詞,地名,一般,*,*\t東京",
          "都\t名詞,普通名詞,一般,*,*,*\t都",
          "へ\t助詞,格助詞,*,*,*,*\tへ",
          "行く\t動詞,非自立可能,*,*,五段-カ行,終止形-一般\t行く",
          "EOS"
        ])
      end
    end
  end
end
