class Tribe
  attr_reader :name, :members
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
    vote_out = Random.new
    vote_out = vote_out.rand(not_immune.length)
    return not_immune[vote_out]
  end
end
