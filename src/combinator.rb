class Combinator < Matcher
  attr_accessor :matchers

  def initialize(*matchers)
    @matchers = matchers.flatten
  end
end

class CombinatorAnd < Combinator
  def call(value)
  	matchers.all? { |matcher| matcher.call(value) }
  end
end

class CombinatorOr < Combinator
  def call(value)
  	matchers.any? { |matcher| matcher.call(value) }
  end
end