require 'rspec'
require_relative '../src/matcher'
require_relative '../src/pattern_matching'

RSpec.configure do |c|
  c.include PatternMatching
end

describe 'My behaviour' do

  it 'val(5) responds to a call(5)' do
    expect(val(5).call(5)).to be true
  end

  it 'val(5) does not respond to a call("5")' do
    expect(val(5).call('5')).to be false
  end

  it 'type(Integer) responds to a call(5)' do
    expect(type(Integer).call(5)).to be true
  end

  it 'type(Symbol) responds to a call("Holis")' do
    expect(type(Symbol).call('Holis')).to be false
  end

  it 'list responds to a call' do
    expect(list([val(1),val(2),val(3)],true).call([1,2,3])).to be true
  end

  it 'listkcxfgjklxf responds to a call' do
    expect(list([val(1),val(2),val(3)]).call([1,2,3])).to be true
  end
end