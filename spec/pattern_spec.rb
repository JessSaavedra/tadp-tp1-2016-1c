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
end