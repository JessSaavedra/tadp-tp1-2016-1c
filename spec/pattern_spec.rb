require 'rspec'
require_relative '../src/pattern_matching'

RSpec.configure do |c|
  c.include PatternMatching
end

describe 'Patterns' do
  it 'matches with' do
    matches?(5)
    expect(with(val(5)){ true }).to be true
  end
end