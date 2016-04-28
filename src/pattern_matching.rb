module PatternMatching
  def val(value)
  	proc { |param| param == value }
  end

  def type(value)
    proc { |param| param.is_a? value }
  end

  def list(list,*boolean)
  	if boolean # true o sin parametro
      proc { |array| (list.size == array.size) & list.collect { |elem| elem.call(array[list.index(elem)]) }.all? }
    else
      proc { |array| (list.size <= array.size) & list.collect { |elem| elem.call(array[list.index(elem)]) }.all? }
    end
  end

  def duck(*methods)
    proc { |object| methods.all? do |method| object.public_methods.include? method end }
  end
end

class Symbol
  def call(value)
    # Bindear
    return true
  end
end