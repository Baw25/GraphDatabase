require 'csv'
require "./practice.rb"
# require_relative "./data.csv"

#Test reading of file 

# data = CSV.read('data.csv')
# CSV.foreach('data.csv') do |row|
#   puts row[0].split("/")
# end
# data = CSV.read('data.csv', { :col_sep => '/' })
graph = GraphDB.new

CSV.foreach('data.csv', { :col_sep => '/' }) do |row| 
  movie_title = row[0].split("(")[0].strip
  year = row[0][/(?:(?:19|20)[0-9]{2})/]
  actors = row[1..row.length]
  graph.add_movie_data(movie_title,year,actors)
end


# p "$" * 20

# p graph.movies
# p "$" * 20
# p graph.actors
# p "$" * 20
# p graph.years

# p graph.count("...Almost")
# p graph.intersect("Myers, Mike","Green, Seth")
# p "$" * 20
# p graph.intersect("Austin Powers: The Spy Who Shagged Me","Austin Powers: International Man of Mystery")


#Set epoch for actors

# p graph.epoch_on
# p graph.intersect("Myers, Mike","Green, Seth")
# p "$" * 20
# graph.set_epoch("1997","1998")
# p graph.epoch_on
# p graph.intersect("Myers, Mike","Green, Seth")
# graph.unset_epoch
# p graph.epoch_on
# p graph.intersect("Myers, Mike","Green, Seth")
# graph.set_epoch("1997","1999")
# p graph.epoch_on
# p graph.intersect("Myers, Mike","Green, Seth")

#Set epoch for movies
p graph.epoch_on
p graph.intersect("Austin Powers: The Spy Who Shagged Me","Austin Powers: International Man of Mystery")
p "$" * 20
graph.set_epoch("1997","1999")
p graph.epoch_on
p graph.intersect("Austin Powers: The Spy Who Shagged Me","Austin Powers: International Man of Mystery")
graph.unset_epoch
p graph.epoch_on
p graph.intersect("Austin Powers: The Spy Who Shagged Me","Austin Powers: International Man of Mystery")




# testmovie1 = MovieNode.new("Lion King", 1998)

# puts testmovie1.title
# puts testmovie1.year
# puts testmovie1.actors
# puts testmovie1.actor_count 
# puts testmovie1.bacon_num

# testmovie2 = MovieNode.new("The Bird Cage", 1995)

# testmovie3 = MovieNode.new("Forrest Gump", 1994)

# # #Test Actor Node: 

# testactor1 = ActorNode.new("Nathan Lane")

# # puts testactor.title
# # puts testactor.movies
# # puts testactor.movie_count
# # puts testactor.bacon_num

# testactor2 = ActorNode.new("Tom Hanks")
# testactor3 = ActorNode.new("Gary Sineas")

# # #Test Year Node: 

# # testyear = YearNode.new("1998")
# # test

# #Create test Graph 


# puts graph.actors
# puts graph.movies
# puts graph.years
# puts graph.epoch_on

#Adding movie node should also aded the corresponding years

# graph.add_movie_node("Lion King", "1998")
# graph.add_movie_node("Forrest Gump", "1994")
# puts "Movies and years"
# puts graph.movies 
# p "-" * 10
# puts graph.years

# p graph

#Want to automatically add an edge between Movie, Actor, and Year
#When initially added 












