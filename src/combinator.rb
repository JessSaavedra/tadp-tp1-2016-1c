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

class CombinatorNot < Matcher
  attr_accessor :matcher

  def initialize(matcher)
    self.matcher = matcher
  end

  def call(value)
    not self.matcher.call(value)
  end
end