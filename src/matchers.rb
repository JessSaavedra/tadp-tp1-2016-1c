require_relative 'binder'

module Matchers

  def val(value)
    proc { |param| param == value }
  end

  def type(value)
    proc { |param| param.is_a? value }
  end

  def list(list,boolean=true) #Si no viene nada, el default es true
    if boolean # true o sin parametro
      proc { |array| (list.size == array.size) & list.zip(array).all? do | elem,value | wrap(elem).call(value) end }
    else
      proc { |array| (list.size <= array.size) & list.zip(array).all? do | elem,value | wrap(elem).call(value) end }
    end
  end

  def duck(*methods)
    proc { |object| methods.all? do |method| object.public_methods.include? method end }
  end

  def wrap(element)
    return element if element.respond_to? :call
    val(element)
  end

end

class Symbol
  def call(value)
    Binder.add_variable(self,value)
    true
  end
end

