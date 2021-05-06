require_relative 'project'
require_relative 'fundrequest'

project1 = Project.new("ABC", 1000, 100)
project2 = Project.new("LMN", 2000, 200)
project3 = Project.new("XYZ", 3000, 300)

vc_friendly = Fund_request.new("VC-Friendly Start-up Projects" )
vc_friendly.load_players(ARGV.shift || "projects.csv")
#vc_friendly.add_project(project1)
#vc_friendly.add_project(project2)
#vc_friendly.add_project(project3)

loop do
  puts "\nHow many rounds? ('quit' to exit)"
  answer = gets.chomp.downcase
  case answer
  when /^\d+$/
      vc_friendly.week(answer.to_i)
  when 'quit', 'exit'
    vc_friendly.print_stats
    break
  else
    puts "Please enter a number or 'quit'"
  end
end

vc_friendly.print_stats
vc_friendly.save_high_scores



