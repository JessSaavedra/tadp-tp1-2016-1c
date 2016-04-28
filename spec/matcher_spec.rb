require 'rspec'
require_relative '../src/pattern_matching'

RSpec.configure do |c|
  c.include PatternMatching
end

describe 'Matchers' do

  class ExampleClass
    def a_method
      'hello!'
    end

    def another_method
      'bye!'
    end
  end

  exampleObject = ExampleClass.new
  
  context 'Values' do
	it 'val(5) responds to a call(5)' do
	  expect(val(5).call(5)).to be true
	end

	it 'val(5) does not respond to a call("5")' do
	  expect(val(5).call('5')).to be false
	end
  end

  context 'Types' do
	it 'type(Integer) responds to a call(5)' do
	  expect(type(Integer).call(5)).to be true
	end

	it 'type(Symbol) responds to a call("Holis")' do
	  expect(type(Symbol).call('Holis')).to be false
	end
  end

  context 'Lists' do
	it 'list responds to a call' do
	  expect(list([val(1),val(2),val(3)],true).call([1,2,3])).to be true
	end

	it 'list responds to a call (sin segundo parametro)' do
	  expect(list([val(1),val(2),val(3)]).call([1,2,3])).to be true
	end

	it 'list does not respond to a call (sin segundo parametro y menos elementos)' do
	  expect(list([val(1),val(2)]).call([1,2,3])).to be false
	end

	it 'list responds to a call (con menos elementos)' do
	  expect(list([val(1),val(2),val(3)],false).call([1,2,3,4])).to be true
	end

	it 'falla el list por orden de los elementos' do
	  expect(list([val(2),val(1),val(3)]).call([10,2,3])).to be false
	end

	it 'se llama con dos val y un type' do
	  expect(list([val(2),type(Integer),val(3)]).call([2,5,3])).to be true
	end
  end

  context 'Duck typing' do
	it 'objeto entiende todos los mensajes del duck y matchea' do
	  expect(duck(:a_method,:another_method).call(exampleObject)).to be true
	end

	it 'objeto no entiende un mensaje del duck y no matchea' do
	  expect(duck(:a_method,:strange_method).call(exampleObject)).to be false
	end

	it 'duck sin metodos matchea siempre' do
	  expect(duck().call(exampleObject)).to be true
	  expect(duck().call(Object.new)).to be true
	  expect(duck().call(:symbol)).to be true
	end

	it 'objeto con metodos propios de su instancia entiende mensajes del duck y matchea' do
	  def exampleObject.own_method
	    'this is mine'
	  end
	  expect(duck(:own_method,:a_method).call(exampleObject)).to be true
	end

	it 'objeto posee mensaje del duck en uno de sus ancestors y matchea' do
	  expect(duck(:to_s).call(exampleObject)).to be true
	end
  end

  context 'Variables' do
  	it 'variable matchea siempre' do
      expect(:hola.call('string')).to be true
  	end
  end
end