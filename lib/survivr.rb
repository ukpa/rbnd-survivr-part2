require_relative "game"
require_relative "tribe"
require_relative "contestant"
require_relative "jury"

#After your tests pass, uncomment this code below
#=========================================================
# # Create an array of twenty hopefuls to compete on the island of Borneo
 @contestants = %w(carlos walter aparna trinh diego juliana poornima juha sofia julia fernando dena orit colt zhalisa farrin muhammed ari rasha gauri)
 @contestants.map!{ |contestant| Contestant.new(contestant) }.shuffle!
#
 # Create two new tribes with names
 @coyopa = Tribe.new(name: "Pagong", members: @contestants.shift(10))
 @hunapu = Tribe.new(name: "Tagi", members: @contestants.shift(10))

 # Create a new game of Survivor
 @borneo = Game.new(@coyopa, @hunapu)
#=========================================================


#This is where you will write your code for the three phases
def phase_one
  eliminated = []
  8.times do
    vote_out_tribe = Random.new
    vote_out_tribe= vote_out_tribe.rand(2)
    elim_tribe = @borneo.tribes[vote_out_tribe]
    element = elim_tribe.tribal_council
    @borneo.tribes[vote_out_tribe].members = @borneo.tribes[vote_out_tribe].members - Array(element)
    eliminated << element
  end
  eliminated.length
end

def phase_two
  @borneo.clear_tribes
  @borneo.add_tribe(@merge_tribe)
  immune = []
  eliminated=[]
  while immune.length!=3
    val = @borneo.individual_immunity_challenge
    immune.push(val) if !immune.include? val
  end
  3.times do
    element = @borneo.tribes.first.tribal_council
    @borneo.tribes.first.members = @borneo.tribes.first.members - Array(element)
    eliminated << element
  end
  @merge_tribe = @borneo.tribes.first
  eliminated.length

end

def phase_three
  jury=[]
  7.times do
    element = @merge_tribe.tribal_council
    @merge_tribe.members = @merge_tribe.members - Array(element)
    jury<< element
  end
  @jury.add_member(jury).flatten!
  jury.length
end


# If all the tests pass, the code below should run the entire simulation!!
#=========================================================
phase_one #8 eliminations
@merge_tribe = @borneo.merge("Cello") # After 8 eliminations, merge the two tribes together
phase_two #3 more eliminations
puts "This shit #{@merge_tribe.members.length}"
@jury = Jury.new
phase_three #7 elminiations become jury members
finalists = @merge_tribe.members #set finalists
puts finalists[0]
puts @jury.class
vote_results = @jury.cast_votes(finalists) #Jury members report votes
@jury.report_votes(vote_results) #Jury announces their votes
@jury.announce_winner(vote_results) #Jury announces final winner
