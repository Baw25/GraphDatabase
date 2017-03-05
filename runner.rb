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

# Tests for count function (make below pass)
# It returns the actor count for a movie
# p graph.count("...Almost")
# it returns the movie count for the actor 
# p graph.count("Ferrell, Will")
# it returns NULL if actor doesn't exist
# it returns NULL if actor doesn't exist
# p graph.count("Washington, Denzel")
# it returns the epoch count for both actors and movies
# p graph.count("Austin Powers: The Spy Who Shagged Me")
# graph.set_epoch("1997","1999")
# graph.epoch_on
# p graph.count("Austin Powers: The Spy Who Shagged Me")
# p graph.count("Myers, Mike")

# Tests for intersection function (make below pass)
#it finds the intersections between 2 actors
# p graph.intersect("Myers, Mike","Green, Seth")

#it finds the intersections between 2 movies
# p graph.intersect("Austin Powers: The Spy Who Shagged Me","Austin Powers: International Man of Mystery")

#it returns NULL when no intersections  
# p graph.intersect("Green, Seth", "Giron, Ali")

#it returns error explaination when not both actors or both movies
# p graph.intersect("Green, Seth", "Cry in the Night, A")

#it returns the epoch intersections for actors and movies
p graph.epoch_on
p graph.intersect("Myers, Mike","Green, Seth")
graph.set_epoch("1997","1998")
p graph.epoch_on
p graph.intersect("Myers, Mike","Green, Seth")
graph.unset_epoch
p graph.epoch_on
p graph.intersect("Myers, Mike","Green, Seth")
graph.set_epoch("1997","1998")
p graph.epoch_on
p graph.intersect("Myers, Mike","Green, Seth")


#Test for set bacon count 

# BACON #
     # -  Kevin Bacon = 0
     # - Any actor sharing a movie with Kevin Bacon = 1
     # - Any other actor = 1 + lowest Bacon number amongst all actors they share movie credit with
     # - Any other actor that doesn’t share a chain of costars leading back to Kevin Bacon = infinity or INF
     # - For a movie = lowest credited Bacon number on any movie credited to that movie or INF if all actors are INF

#give Kevin bacon a score 











