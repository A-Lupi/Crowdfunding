module Fundable

  def add_fund
    self.funding += 25
    puts "Project #{@name} got some funds!"
  end

  def remove_fund
    self.funding -= 15
    puts "Project #{@name} lost some funds!"
  end

  def fully_funded?
    funding == goal
  end

  def total_funds
    self.funding + self.pledges
  end
  
end