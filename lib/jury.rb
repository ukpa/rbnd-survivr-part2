class Jury
  attr_reader :members,:finalists
  def initialize
    @members=[]
    @finalists={}
  end
  def add_member(member)
    @members << member
  end
  def cast_votes(finalists)
    counter=0
      finalists.each do |finalist|
        @finalists[finalist] = 0
      end
      @members.each do |member|
        vote = Random.new
        vote=vote.rand(finalists.length)
        @finalists[finalists[vote]]+=1
        p ""
      end
      @finalists
  end

  def report_votes(final_votes)
    final_votes.each do |finalist,votes|
      puts "Finalist: #{finalist.to_s} | Votes: #{votes}"
    end
  end

  def announce_winner(final_votes)
    final_votes.each do |finalist,votes|
      if votes == final_votes.values.max
        puts "----------------------------------------"
        puts "Yay, our winner is:"
        puts "#{finalist.to_s.pink}"
        return finalist
      end
    end
  end
end
