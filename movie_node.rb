#Relationships between the graph nodes: 

#Movie node has many actor nodes 
#Movie node has only one year node 
#Actor node has many movie nodes
#Actor node will have many year nodes through the movie nodes
#Year node has many movie nodes 
#Year node has many actor nodes through movies

# Movie Node class
class MovieNode
  attr_accessor :actors, :actor_count,:bacon_num
  attr_reader :title, :year

  def initialize(title,year)
    @title = title 
    @year = year.to_i #belongs to specific year node
    @actors = {} #Edges with actor nodes or actors belonging to movie
    @actor_count = 0 #Count of actors
    @bacon_num = "INF" #Associated bacon number
  end 
  
end
