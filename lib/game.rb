class Game
  attr_accessor :tribes
  def initialize(tribe1,tribe2)
    @tribes = []
    @tribes << tribe1
    @tribes << tribe2
  end

  def add_tribe(tribe)
    @tribes << tribe
  end

  def immunity_challenge
    @tribes.sample
  end

  def clear_tribes
    @tribes = []
  end

  def merge(val)
    combined_tribe={}
    combined_tribe[:name] = val
    combined_tribe[:members] = []
    @tribes.each do |tribe|
      combined_tribe[:members] << tribe.members
    end
    combined_tribe[:members].flatten!
    Tribe.new(combined_tribe)
  end

  def individual_immunity_challenge
    @tribes.first.members.sample
  end
end
