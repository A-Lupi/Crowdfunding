require_relative 'die'
require_relative 'fundrequest'
require_relative 'pledge_trove'

module FundingRound

    def self.take_turn(project)
      die = Die.new
      case die.roll
      when 1..2
        project.remove_fund
      when 3..4
        puts "#{project.name} was skipped."
      else
        project.add_fund
      end
      
      pledge = PledgeTrove.random
      project.received_pledge(pledge)
    end
end