class Matcher
  attr_accessor :parameter

  def initialize(value)
   @parameter = value
  end

end

class ValueMatcher < Matcher

  def call(value)
  	@parameter == value
  end
end

class TypeMatcher < Matcher

  def call(value)
    value.is_a? @parameter
  end
end

class ListMatcher < Matcher
  attr_accessor :boolean

  def initialize(list,*boolean)
   @parameter = list
   @boolean =  boolean ? boolean[0] : true

  end

  def call(array)
    if boolean
      return false unless @parameter.size == array.size
    else
      return false if @parameter.size > array.size
      #Lo pusimos xq 
    end
    compare(@parameter,array)
  end

  def compare(an_array,other_array)
    an_array.collect { |elem| elem.call(other_array[an_array.index(elem)])  }.all?
  end
end
