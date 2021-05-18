require_relative 'project'

class MatchingProject < Project
  
  def initialize(name, goal, funding=0)
    super(name, goal, funding)
    @halfway_funded = goal / 2
  end
  
  def halfway_funded?
    @halfway_funded <= funding
  end
  
  def add_fund
    if halfway_funded?
      @funding += (25*2)
      puts "#{@name} has received at least half its funding!" if halfway_funded?
    else
      super
    end
  end
  
end

if __FILE__ == $0
  matchingproject = MatchingProject.new("Matching 123", 100, 0)
  3.times { matchingproject.add_fund }
  puts matchingproject.funding
end