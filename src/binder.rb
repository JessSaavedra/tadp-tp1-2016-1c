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