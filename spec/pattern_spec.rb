require 'rspec'
require_relative '../src/pattern_matching'

RSpec.configure do |c|
  c.include PatternMatching
end

describe 'Patterns' do
  it 'matches with val' do
    expect(matches?(5) do with(val(5)){ 4 } end ).to eq 4
  end

  it 'matches second with' do
    expect(matches?(5) do with(val(10)){ 8 }
    	                    with(val(5)){ 4 }
    	               end ).to eq 4
  end

  it 'matches only first with' do
    expect(matches?(5) do with(val(5)){ 8 }
    	                    with(val(5)){ 4 }
    	               end ).to eq 8
  end

  it 'matches otherwise' do
    expect(matches?(5) do with(val(4)){ 8 }
                          with(val(3)){ 8 }
                          otherwise{ 'aca entro' }
                          with(val(3)){ 'aca no' }
    end ).to eq 'aca entro'
  end

  it 'matches with and no otherwise' do
    expect(matches?(5) do with(val(4)){ 8 }
    with(val(5)){ 'aca entro' }
    otherwise{ 'aca no entro' }
    with(val(3)){ 'aca no' }
    end ).to eq 'aca entro'
  end

  it 'matches con bloque que requiere binding' do
    expect(
        matches?([1,2,3]) do
          with(list([:a, val(2), duck(:+)])) { a + 2 }
          with(list([1,2,3])) { 'acá no llego'}
        end)
        .to eq 3
  end

  it 'matches con bloque que requiere binding con string' do
    expect(
        matches?('text') do
          with(type(String), :a_string) { a_string.length }
        end)
        .to eq 4
  end

  it 'matches con lista que bindea los valores' do
    expect(
        matches?([5,4,'text']) do
          with(list([:a_number,type(String),:a_text])) { a_text }
          with(list([:a_number,type(Integer),:a_text])) { a_number.to_s + a_text }
        end)
        .to eq '5text'
  end

  it 'with que no recibe matchers ejecuta el bloque' do
    expect(
        matches?(1) do
          with() { 'acá llega' }
          with(type(Integer)) { 10 }
        end)
        .to eq 'acá llega'
  end
end