require 'rspec'
require_relative '../src/pattern_matching'

RSpec.configure do |c|
  c.include PatternMatching
end

describe 'Patterns' do
  it 'matches with' do
    expect(matches?(5) do with(val(5)){ 4 } end ).to eq 4
  end

  it 'matches with' do
    expect(matches?(5) do with(val(10)){ 8 }
    	                  with(val(5)){ 4 } 
    	               end ).to eq 4
  end

  it 'matches with' do
    expect(matches?(5) do with(val(5)){ 8 }
    	                  with(val(5)){ 4 } 
    	               end ).to eq 8
  end

  it 'matches con bloque que requiere binding' do
    expect(
        matches?([1,2,3]) do
          with(list([:a, val(2), duck(:+)])) { a + 2 }
          with(list([1,2,3])) { 'acá no llego'}
        end)
        .to eq 3
  end
  
end