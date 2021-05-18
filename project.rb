require_relative 'pledge_trove'
require_relative 'fundable'

class Project
  include Fundable 
  
  attr_accessor :name, :funding, :goal

  def initialize(name, goal, funding=0)
    @name = name
    @funding = funding
    @goal = goal
    @received_pledges = Hash.new(0)
  end

  def to_s
    "Project #{@name} has $#{total_funds} in funding towards a goal of $#{@goal}."
  end

  def until_goal
    @goal - @funding
  end

  def received_pledge(pledge)
    @received_pledges[pledge.category] += pledge.value
    puts "Project #{@name} received a #{pledge.category} pledge worth $#{pledge.value}."
    puts "Project #{@name}'s pledges: #{@received_pledges}"
  end

  def pledges
    @received_pledges.values.reduce(0, :+)
  end

  def each_received_pledge
    @received_pledges.each do |category, value|
      yield Pledge.new(category, value)
    end
  end

end