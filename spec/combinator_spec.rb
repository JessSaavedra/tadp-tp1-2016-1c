require 'rspec'
require_relative '../src/combinator'
require_relative '../src/pattern_matching'

RSpec.configure do |c|
  c.include PatternMatching
end

describe 'Combinators' do

  it 'and de dos matchers genera un Proc' do
    matcher_type = type(Integer)
    matcher_val = val(5)

    and_combinator = matcher_type.and(matcher_val)

    expect(and_combinator.class).to be Proc
  end

  it 'or de dos matchers genera un Proc' do
    matcher_type = type(Integer)
    matcher_val = val(5)

    or_combinator = matcher_type.or(matcher_val)

    expect(or_combinator.class).to be Proc
  end

  it 'not de un matcher genera un Proc' do
    a_matcher = type(Symbol)

    not_combinator = a_matcher.not

    expect(not_combinator.class).to be Proc
  end

  it 'combinator and con dos matchers' do
  	expect(type(Integer).and(val(5)).call(5)).to be true
  end

  it 'combinator and con tres matchers' do
  	expect(type(Integer).and(val(5),duck(:+)).call(5)).to be true
  end

  it 'combinator and con primer matcher invalido' do
    expect(type(String).and(val(5),duck(:+)).call(5)).to be false
  end

  it 'combinator or con dos matchers' do
  	expect(type(Integer).or(val(6)).call(5)).to be true
  end

  it 'combinator or con tres matchers' do
  	expect(type(String).or(val(6),duck(:+)).call(5)).to be true
  end

  it 'combinator and with or' do
    expect(type(String).and(val('hola')).or(val(5)).call(5)).to be true
  end

  it 'combinator not de matcher que no cumple' do
    expect(type(String).not.call(5)).to be true
  end

  it 'combinator not de matcher que cumple' do
    expect(type(String).not.call('hola')).to be false
  end

  it 'not combinator aplicado sobre un and que cumple' do
    expect(type(Fixnum).and(duck(:-)).not.call(3)).to be false
  end

  it 'not combinator aplicado sobre un or que no cumple' do
    expect(type(Fixnum).or(duck(:-)).not.call(:a_symbol)).to be true
  end

end