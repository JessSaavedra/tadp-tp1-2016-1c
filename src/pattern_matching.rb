module PatternMatching
	attr_accessor :object

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
  	block.call if matchers.all? do |matcher| matcher.call(self.object) end
  end 

  def matches?(x)
  	self.object= x
  end
end

class Symbol
  def call(value)
    # Bindear
    return true
  end
end