require 'rspec'
require_relative '../src/pattern_matching'

RSpec.configure do |c|
  c.include PatternMatching
end

describe 'Patterns' do
  it 'matches with' do
    expect(matches?(5) do with(val(5)){ 4 } end ).to be 4
  end

  it 'matches with' do
    expect(matches?(5) do with(val(10)){ 8 }
    	                  with(val(5)){ 4 } 
    	               end ).to be 4
  end
end