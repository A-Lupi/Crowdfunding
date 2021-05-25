require_relative 'project'
require_relative 'funding_round'
require_relative 'pledge_trove'
require 'csv'

class Fund_request
  def initialize(title)
    @title = title
    @projects = []
  end

  def add_project(project)
    @projects << project
  end

  def week(times)
    puts "There are #{@projects.size} projects avaible that you could fund:"

    @projects.each do |project|
      puts project
    end

    pledges = PledgeTrove::PLEDGES
    puts "\nThere are #{pledges.size} possible pledge ammounts:"
    pledges.each do |pledge|
      puts "A #{pledge.category} pledge is worth $#{pledge.value}"
    end

    1.upto(times) do |week|
      @projects.each do |project|
        puts "\nWeek #{week}:"
        FundingRound.take_turn(project)
        puts project
      end
    end 
  end

  def print_name_goal(project)
    puts "#{project.name} #{project.total_funds}/#{project.goal}"
  end

  def fully_funded_projects
    @projects.select { |project| project.fully_funded? }
  end

  def under_funded_projects
    @projects.reject { |project| project.fully_funded? }
  end

  def print_stats
    fully_funded, under_funded = @projects.partition {|player| player.fully_funded?}
    puts "\n#{@title} Statistics:"

    puts "\n#{fully_funded.size} Fully funded projects:"
    fully_funded.each do |project|
      print_name_goal(project)
    end
    puts "\n#{under_funded.size} Under funded projects:"
    under_funded.each do |project| 
      print_name_goal(project)
    end

    puts "\n#{@title} High Scores:"
    @projects.sort_by {|project| -project.total_funds}.each do |project|
      puts high_score_entry(project)
    end

    puts "\n#{@title} Project pledge funds:"
    @projects.each do |project|
      puts "\n#{project.name}'s pledge totals:"
      project.each_received_pledge do |pledge|
        puts "#{pledge.category.capitalize} pledge worth $#{pledge.value}"
      end
      puts "$#{project.pledges} total worth"
    end
  end

  def load_players(from_file)
    CSV.foreach(from_file) do |row|
      project = Project.new(row[0], row[1].to_i, row[2].to_i)
      add_project(project)
    end
  end

  def high_score_entry(project)
    formatted_name = project.name.ljust(20, '.')
    "#{formatted_name} $#{project.total_funds}/$#{project.goal}"
  end

  def save_high_scores(to_file="projects_funding.txt")
    File.open(to_file, "w") do |file|
      file.puts "#{@title} that need funding:"
      @projects.sort_by {|project| -project.total_funds}.each do |project|
        file.puts high_score_entry(project)
      end
    end
  end

end
