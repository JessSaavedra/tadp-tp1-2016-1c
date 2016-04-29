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
  	  if matchers.all? do |matcher| matcher.call(self.object) end
  	    self.flag= true
  	    self.matching_block= block
  	  end
  	end
  end 

  def matches?(x,&block)
  	self.flag= false
  	self.object= x
  	block.call
  	matching_block.call
  end
end

class Symbol
  def call(value)
    # Bindear
    return true
  end
end