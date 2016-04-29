module PatternMatching
	attr_accessor :object, :flag, :matching_block

  def val(value)
  	proc { |param| param == value }
  end

  def type(value)
    proc { |param| param.is_a? value }
  end

  def list(list,boolean=true) #Si no viene nada, el default es true
  	if boolean # true o sin parametro
      proc { |array| (list.size == array.size) & list.collect { |elem| elem.call(array[list.index(elem)]) }.all? }
    else
      proc { |array| (list.size <= array.size) & list.collect { |elem| elem.call(array[list.index(elem)]) }.all? }
    end
  end

  def duck(*methods)
    proc { |object| methods.all? do |method| object.public_methods.include? method end }
  end

  def with(*matchers,&block)
  	if not self.flag
      Binder.reset
  	  if matchers.all? do |matcher| matcher.call(self.object) end
        self.matched block
  	  end
  	end
  end

  def otherwise(&block)
    self.matched block
  end

  def matched(block)
    self.flag= true
    self.matching_block= block
  end

  def matches?(x,&block)
  	self.flag= false
  	self.object= x
  	block.call
  	Binder.new.instance_eval &matching_block
  end
end


class Binder
  @@variables = Hash.new

  def self.reset
    @@variables = Hash.new
  end

  def self.add_variable(name,value)
    @@variables[name] = value
  end

  def initialize
    @@variables.keys.each do | variable |
      self.define_singleton_method(variable) { @@variables[variable] }
    end
  end
end


class Symbol
  def call(value)
    Binder.add_variable(self,value)
    return true
  end
end