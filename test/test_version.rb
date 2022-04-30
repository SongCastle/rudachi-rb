require_relative 'test_helper'

describe Rudachi::RB::VERSION do
  it 'current Rudachi-rb version' do
    expect(Rudachi::RB::VERSION).must_equal('1.0.0')
  end
end
