require_relative 'pledge_trove'

class Project
  attr_accessor :name
  attr_reader :funding, :goal

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

  def add_fund
    @funding += 25
    puts "Project #{@name} got some funds!"
  end

  def remove_fund
    @funding -= 15
    puts "Project #{@name} lost some funds!"
  end

  def fully_funded?
    @funding == @goal
  end

  def received_pledge(pledge)
    @received_pledges[pledge.category] += pledge.value
    puts "Project #{@name} received a #{pledge.category} pledge worth $#{pledge.value}."
    puts "Project #{@name}'s pledges: #{@received_pledges}"
  end

  def pledges
    @received_pledges.values.reduce(0, :+)
  end

  def total_funds
    @funding + pledges
  end

  def each_received_pledge
    @received_pledges.each do |category, value|
      yield Pledge.new(category, value)
    end
  end

end