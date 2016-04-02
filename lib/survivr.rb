require_relative "game"
require_relative "tribe"
require_relative "contestant"
require_relative "jury"
require 'colorizr'

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
    elim_tribe = @borneo.immunity_challenge
    index = @borneo.tribes.index(elim_tribe)
    element = elim_tribe.tribal_council
    @borneo.tribes[index].members = @borneo.tribes[index].members - Array(element)
    eliminated << element
  end
  puts "Phase 1 eliminations: ".red
  puts "----------------------------------------"
  eliminated.each_with_index do |contestants,index|
    puts "#{index+1}: #{contestants}"
  end
  puts "----------------------------------------"
  eliminated.length
end

def phase_two
  @borneo.clear_tribes
  @borneo.add_tribe(@merge_tribe)
  @immune = []
  eliminated=[]
  while @immune.length!=3
    val = @borneo.individual_immunity_challenge
    @immune.push(val) if !@immune.include? val
  end
  3.times do
    element = @borneo.tribes.first.tribal_council(immune: @immune)
    @borneo.tribes.first.members = @borneo.tribes.first.members - Array(element)
    eliminated << element
  end
  puts "Phase 2 Winners".green
  puts "----------------------------------------"
  @immune.each_with_index do |winner,index|
    puts "#{index+1}: #{winner}"
  end
  puts "----------------------------------------"
  puts "Phase 2 Eliminations".red
  puts "----------------------------------------"
  eliminated.each_with_index do |contestant,index|
    puts "#{index+1}: #{contestant}"
  end
  puts "----------------------------------------"

  @merge_tribe = @borneo.tribes.first
  eliminated.length

end

def phase_three
  immune = @immune.sample
  jury=[]
  7.times do
    element = @merge_tribe.tribal_council(immune: immune)
    @merge_tribe.members = @merge_tribe.members - Array(element)
    jury<< element
  end
  @jury.add_member(jury).flatten!

  puts "Jury".yellow
  puts "----------------------------------------"
  jury.each_with_index do |member,index|
    puts "#{index+1}: #{member}"
  end
  puts "----------------------------------------"
  puts "Finalists".green
  puts "----------------------------------------"
  @merge_tribe.members.each_with_index do |finalist,index|
    puts "#{index+1}: #{finalist}"
  end
  puts "----------------------------------------"
  jury.length
end


# If all the tests pass, the code below should run the entire simulation!!
#=========================================================
phase_one #8 eliminations
@merge_tribe = @borneo.merge("Cello") # After 8 eliminations, merge the two tribes together
phase_two #3 more eliminations
@jury = Jury.new
phase_three #7 elminiations become jury members
finalists = @merge_tribe.members #set finalists
puts finalists[0]
puts @jury.class
vote_results = @jury.cast_votes(finalists) #Jury members report votes
@jury.report_votes(vote_results) #Jury announces their votes
@jury.announce_winner(vote_results) #Jury announces final winner
