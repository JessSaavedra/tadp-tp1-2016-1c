module PatternMatching
  def val(value)
  	ValueMatcher.new(value)
  end

  def type(value)
    TypeMatcher.new(value)
  end

  def list(list,*boolean)
  	ListMatcher.new(list,*boolean)
  end

  def duck(*methods)
    DuckMatcher.new(*methods)
  end
end