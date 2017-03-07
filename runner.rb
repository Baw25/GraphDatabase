require 'csv'
require "./graph"

#Welcome User
puts "#" * 50
puts " " * 10 + "Welcome to the GraphDB CLI"
puts "#" * 50 

puts "Data is loading ..."
#Seed the database
graph = GraphDB.new

CSV.foreach('total_data.csv', { :col_sep => '/' }) do |row| 
  movie_title = row[0].split("(")[0].strip
  year = row[0][/(?:(?:19|20)[0-9]{2})/]
  actors = row[1..row.length]
  graph.add_movie_data(movie_title,year,actors)
end


# Interactive Command Line Program 
# Directions
puts """ \n
  The IMDB movie data is now loaded.\n
  \n
  Please choose the following commands to query:\n

  COUNT <actor>/<movie>- Reveals credited movies or actors\n
  INTERSECT <actor> <actor>/<movie> <movie> - Reveals movies or actors intersections\n
  BACON <actor>/<movie> - Reveals bacon number for actor or movie\n
  SET_EPOCH <year1> <year2> - sets years filter\n
  UNSET_EPOCH - unsets years filter\n
  END - end the program\n
  Directions:\n
  - Please enter pipe char after command ex: COUNT |
  - Please separate entities (actors, movies) with | pipe char if more than one
  - Enter actors lastname, firstname format ex: \"Myers, Mike\"
  \n
"""

loop do 
  puts "Enter Command\n"
  inputs = gets.chomp

  if inputs == "END"
    break
  end 

  inputs = inputs.split("|") 

  #optional third input 
  if inputs[2]
    input3 = inputs[2].strip
  end

  #optional second input
  if inputs[1]
    input2 = inputs[1].strip
  end

  #command input
  input1 = inputs[0].strip

  # p inputs
  # p input1
  # p input2
  # p input3

  case input1
  when "COUNT" 
    puts graph.count(input2)
  when "INTERSECT"
    graph.intersect(input2, input3)
  when "BACON"
    puts graph.bacon(input2)
  when "SET_EPOCH"
    puts graph.set_epoch(input2,input3)
  when "UNSET_EPOCH"
    puts graph.unset_epoch
  else 
    puts "Invalid command"
  end 

end 

