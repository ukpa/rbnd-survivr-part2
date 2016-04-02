class Jury
  attr_accessor :members,:finalists
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
        puts @finalists[finalists[vote]]+=1
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
        puts finalist
        return finalist
      end
    end
  end
end
