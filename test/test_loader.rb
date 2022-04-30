require_relative 'test_helper'

describe Rudachi::Loader do
  describe '.load!' do
    it 'loads Sudachi dependencies' do
      expect { Rudachi::Loader.load! }.wont_raise
    end

    describe 'when a platform is Java' do
      it 'raises `UnavailableError`' do
        stub_const('RUBY_PLATFORM','java') do
          err = expect { Rudachi::Loader.load! }.must_raise(Rudachi::Loader::UnavailableError)
          expect(err.message).must_equal('ruby_required')
        end
      end
    end
  end
end
