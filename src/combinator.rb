class Proc
  def and(*matchers)
    proc { |param| matchers.concat([self]).all? do |matcher| matcher.call param end }
  end

  def or(*matchers)
    proc { |param| matchers.concat([self]).any? do |matcher| matcher.call param end }
  end

  def not
    proc { |param| not self.call param }
  end
end