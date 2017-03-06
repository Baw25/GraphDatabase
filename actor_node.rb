#Relationships between the graph nodes: 

#Movie node has many actor nodes 
#Movie node has only one year node 
#Actor node has many movie nodes
#Actor node will have many year nodes through the movie nodes
#Year node has many movie nodes 
#Year node has many actor nodes through movies

#Actor node class
class ActorNode
  attr_accessor :movies,:movie_count, :bacon_num
  attr_reader :title
  
  def initialize(title)
    @title = title 
    @movies = {} #Edges with movie nodes or actor's movies
    @movie_count = 0 #movie count
    @costars = {} #movie key : actors array 
    @bacon_num = "INF" #Associated bacon number
  end 

end
