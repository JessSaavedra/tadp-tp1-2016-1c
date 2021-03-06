require_relative 'matchers'

module PatternMatching
  include Matchers

	attr_accessor :object, :flag, :matching_block

  def with(*matchers,&block)
  	if not self.flag
      Binder.reset
  	  if matchers.all? do |matcher| matcher.call(self.object) end
        self.matched block
  	  end
  	end
  end

  def otherwise(&block)
    self.with(val(self.object),&block)
  end

  def matched(block)
    self.flag= true
    self.matching_block= block
  end

  def matches?(x,&block)
  	self.flag= false
  	self.object= x
  	block.call
  	Binder.new.instance_eval &matching_block
  end
end


