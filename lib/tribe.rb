class Tribe
  attr_accessor :name, :members

  def initialize(options={})
    @name = options[:name]
    @members = options[:members]
    puts self
  end

  def to_s
    @name
  end

  def tribal_council(options={})
    not_immune = (@members - Array(options[:immune]))
    not_immune.sample
  end
end
