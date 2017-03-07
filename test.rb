require 'csv'
require "./graph"
# require "./test_data.csv"

#Test reading of file 

# data = CSV.read('data.csv')
# CSV.foreach('data.csv') do |row|
#   puts row[0].split("/")
# end
# data = CSV.read('data.csv', { :col_sep => '/' })
graph = GraphDB.new


CSV.foreach('test_data.csv', { :col_sep => '/' }) do |row| 
  movie_title = row[0].split("(")[0].strip
  year = row[0][/(?:(?:19|20)[0-9]{2})/]
  actors = row[1..row.length]
  graph.add_movie_data(movie_title,year,actors)
end
# # Tests for count function (make below pass)
# # It returns the actor count for a movie
# p graph.count("Austin Powers: The Spy Who Shagged Me")
# p graph.actor_count
# # it returns the movie count for the actor 
# # p graph.count("Ferrell, Will")
# # it returns NULL if actor doesn't exist
# # it returns NULL if actor doesn't exist
# # p graph.count("Washington, Denzel")
# # it returns the epoch count for both actors and movies
# # p graph.count("Austin Powers: The Spy Who Shagged Me")
# # graph.set_epoch("1997","1999")
# # graph.epoch_on
# # p graph.count("Austin Powers: The Spy Who Shagged Me")
# # p graph.count("Myers, Mike")

# # Tests for intersection function (make below pass)
# #it finds the intersections between 2 actors
p graph.intersect("Myers, Mike","Green, Seth")

# #it finds the intersections between 2 movies
p graph.intersect("Austin Powers: The Spy Who Shagged Me","Austin Powers: International Man of Mystery")

# #it returns NULL when no intersections  
# # p graph.intersect("Green, Seth", "Giron, Ali")

# #it returns error explaination when not both actors or both movies
# # p graph.intersect("Green, Seth", "Cry in the Night, A")

# #it returns the epoch intersections for actors and movies
# p graph.epoch_on
# p graph.intersect("Myers, Mike","Green, Seth")
# graph.set_epoch("1997","1998")
# p graph.epoch_on
# p graph.intersect("Myers, Mike","Green, Seth")
# graph.unset_epoch
# p graph.epoch_on
# p graph.intersect("Myers, Mike","Green, Seth")
# graph.set_epoch("1997","1998")
# p graph.epoch_on
# p graph.intersect("Myers, Mike","Green, Seth")


# #Test for set bacon count 

# # BACON #
#      # -  Kevin Bacon = 0
#      # - Any actor sharing a movie with Kevin Bacon = 1
#      # - Any other actor = 1 + lowest Bacon number amongst all actors they share movie credit with
#      # - Any other actor that doesn’t share a chain of costars leading back to Kevin Bacon = infinity or INF
#      # - For a movie = lowest credited Bacon number on any movie credited to that movie or INF if all actors are INF

# #give Kevin bacon a score of zero when seeding 

#   # def add_actor_node(title,movie_title)
#   #   if !@actors[title]
#   #     actor_node = ActorNode.new(title)
#   #     actor_node.movies[movie_title] = movie_title
#   #     actor_node.movie_count += 1
#   #     @actors[title]= actor_node
#   #     @actor_count += 1
#   #   else
#   #     @actors[title].movies[movie_title] = movie_title
#   #     @actors[title].movie_count += 1
#   #   end
#   # end

# #Situations: 
# #if movie contain Kevin Bacon --> 
#   # - Kevin Bacon assigned 0 
#   # - Movie assigned 0 
#   # - All other actors in movie assigned 1 
# #if movie contains

# Perform a BFS from the starting node.


distances = {}
def get_bacon(entity)
  #base cases
  if entity == "Bacon, Kevin" 
    return "Bacon number: 0"
  end
  if @movies[entity].actors["Bacon, Kevin"]
    return "Bacon number: 0"
  end
  #movie and actor calculations
  if @movies[entity]
    return calculate_movie_bacon(entity)
  else
    return calculate_actor_bacon(entity)
  end
end

# Create a ‘distance’ hashtable.
# Store each vertex value as the key, and a distance of INFINITY
# Set the ‘start’ vertex value to 0
# Create a ‘visited’ hashtable
# Store each vertex value as the key and a visited to false
# Instantiate a queue and place the starting vertex in the queue
# While there is something in the queue
# Dequeue the ‘current’ vertex and mark it as visited.
# For each edge, if the associated ‘neighbor’ has not been visited
# Update the neighbor’s ‘distance’ as the minimum of:
# the distance of ‘neighbor’
# the distance of the ‘current’ + 1
# Add the neighbor to the queue
# Return the distance of ‘end’ vertex

def calculate_movie_bacon(movie_title)
  distances = {}
  visited = {}
  queue = []
  result = []
  movie_keys = @movies[movie_title].actors.keys
  queue.push(@movies[movie_keys[0]])
  visited[movie_keys[0]] = true 
  pointer = 0

  while pointer < queue.length
    current_node = queue[pointer]
    current_node.edges.each do |edge, value|
      if !traveled.key?(edge)
        queue.push(@vertices[edge])
        traveled[edge] = true
      end
    end
    result.push(current_node.value)
    pointer += 1
  end

  return result
end

def calculate_actor_bacon(actor)

end








