require 'rspec'
require_relative '../src/matcher'
require_relative '../src/combinator'
require_relative '../src/pattern_matching'

RSpec.configure do |c|
  c.include PatternMatching
end

describe 'Combinators' do
  
  it 'combinator and con dos matchers' do
  	expect(type(Integer).and(val(5)).call(5)).to be true
  end

  it 'combinator and con tres matchers' do
  	expect(type(Integer).and(val(5),duck(:+)).call(5)).to be true
  end

  it 'combinator or con dos matchers' do
  	expect(type(Integer).or(val(6)).call(5)).to be true
  end

  it 'combinator or con tres matchers' do
  	expect(type(String).or(val(6),duck(:+)).call(5)).to be true
  end
end