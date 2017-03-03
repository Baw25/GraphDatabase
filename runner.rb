require "./practice.rb"

#Test MovieNodes

testmovie1 = MovieNode.new("Lion King", 1998)

# puts testmovie1.title
# puts testmovie1.year
# puts testmovie1.actors
# puts testmovie1.actor_count 
# puts testmovie1.bacon_num

testmovie2 = MovieNode.new("The Bird Cage", 1995)

testmovie3 = MovieNode.new("Forrest Gump", 1994)

# #Test Actor Node: 

testactor1 = ActorNode.new("Nathan Lane")

# puts testactor.title
# puts testactor.movies
# puts testactor.movie_count
# puts testactor.bacon_num

testactor2 = ActorNode.new("Tom Hanks")
testactor3 = ActorNode.new("Gary Sineas")

# #Test Year Node: 

# testyear = YearNode.new("1998")
# test

#Create test Graph 

graph = GraphDB.new

# puts graph.actors
# puts graph.movies
# puts graph.years
# puts graph.epoch_on

#Adding movie node should also aded the corresponding years

graph.add_movie_node("Lion King", "1998")
graph.add_movie_node("Forrest Gump", "1994")
puts "Movies and years"
puts graph.movies 
p "-" * 10
puts graph.years









